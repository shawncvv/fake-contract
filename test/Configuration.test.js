const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Project Configuration Validation", function () {
  describe("Hardhat Configuration", function () {
    it("Should have valid hardhat.config.js", function () {
      const configPath = path.join(__dirname, "..", "hardhat.config.js");
      expect(fs.existsSync(configPath)).to.be.true;
    });

    it("Should specify correct Solidity version", function () {
      const configPath = path.join(__dirname, "..", "hardhat.config.js");
      const configContent = fs.readFileSync(configPath, "utf8");
      
      expect(configContent).to.include("0.8.6");
    });

    it("Should have required toolbox plugin", function () {
      const configPath = path.join(__dirname, "..", "hardhat.config.js");
      const configContent = fs.readFileSync(configPath, "utf8");
      
      expect(configContent).to.include("hardhat-toolbox");
    });
  });

  describe("Package Configuration", function () {
    it("Should have valid package.json", function () {
      const packagePath = path.join(__dirname, "..", "package.json");
      expect(fs.existsSync(packagePath)).to.be.true;
      
      const packageContent = JSON.parse(fs.readFileSync(packagePath, "utf8"));
      expect(packageContent).to.have.property("name");
      expect(packageContent).to.have.property("version");
      expect(packageContent).to.have.property("scripts");
    });

    it("Should have test script defined", function () {
      const packagePath = path.join(__dirname, "..", "package.json");
      const packageContent = JSON.parse(fs.readFileSync(packagePath, "utf8"));
      
      expect(packageContent.scripts).to.have.property("test");
      expect(packageContent.scripts.test).to.include("hardhat test");
    });

    it("Should have required dependencies", function () {
      const packagePath = path.join(__dirname, "..", "package.json");
      const packageContent = JSON.parse(fs.readFileSync(packagePath, "utf8"));
      
      expect(packageContent.devDependencies).to.have.property("hardhat");
      expect(packageContent.devDependencies).to.have.property("@nomicfoundation/hardhat-toolbox");
    });
  });

  describe("Contract Structure", function () {
    it("Should have contracts directory", function () {
      const contractsPath = path.join(__dirname, "..", "contracts");
      expect(fs.existsSync(contractsPath)).to.be.true;
    });

    it("Should have GAIX.sol in contracts directory", function () {
      const contractPath = path.join(__dirname, "..", "contracts", "GAIX.sol");
      expect(fs.existsSync(contractPath)).to.be.true;
    });

    it("Should have valid Solidity syntax in GAIX.sol", function () {
      const contractPath = path.join(__dirname, "..", "contracts", "GAIX.sol");
      const contractContent = fs.readFileSync(contractPath, "utf8");
      
      expect(contractContent).to.include("pragma solidity");
      expect(contractContent).to.include("contract GAIX");
    });
  });

  describe("Test Structure", function () {
    it("Should have test directory", function () {
      const testPath = path.join(__dirname, "..", "test");
      expect(fs.existsSync(testPath)).to.be.true;
    });

    it("Should have comprehensive GAIX test file", function () {
      const testPath = path.join(__dirname, "GAIX.test.js");
      expect(fs.existsSync(testPath)).to.be.true;
      
      const testContent = fs.readFileSync(testPath, "utf8");
      expect(testContent).to.include("describe");
      expect(testContent).to.include("it(");
      expect(testContent).to.include("expect");
    });

    it("Should have documentation validation tests", function () {
      const docTestPath = path.join(__dirname, "Documentation.test.js");
      expect(fs.existsSync(docTestPath)).to.be.true;
    });

    it("Should have configuration validation tests", function () {
      const cfgTestPath = path.join(__dirname, "Configuration.test.js");
      expect(fs.existsSync(cfgTestPath)).to.be.true;
    });
  });

  describe("Git Configuration", function () {
    it("Should have .git directory", function () {
      const gitPath = path.join(__dirname, "..", ".git");
      expect(fs.existsSync(gitPath)).to.be.true;
    });

    it("Should have README.md", function () {
      const readmePath = path.join(__dirname, "..", "README.md");
      expect(fs.existsSync(readmePath)).to.be.true;
    });
  });

  describe("Contract Metadata Validation", function () {
    it("Should have proper contract header comments", function () {
      const contractPath = path.join(__dirname, "..", "contracts", "GAIX.sol");
      const contractContent = fs.readFileSync(contractPath, "utf8");
      
      expect(contractContent).to.match(/\/\*\*[\s\S]*?\*\//);
    });

    it("Should have SPDX license identifier", function () {
      const contractPath = path.join(__dirname, "..", "contracts", "GAIX.sol");
      const contractContent = fs.readFileSync(contractPath, "utf8");
      
      expect(contractContent).to.include("SPDX-License-Identifier");
    });

    it("Should specify contract interfaces", function () {
      const contractPath = path.join(__dirname, "..", "contracts", "GAIX.sol");
      const contractContent = fs.readFileSync(contractPath, "utf8");
      
      expect(contractContent).to.include("interface IERC20");
    });
  });

  describe("File Integrity Checks", function () {
    it("Should have non-empty contract file", function () {
      const contractPath = path.join(__dirname, "..", "contracts", "GAIX.sol");
      const stats = fs.statSync(contractPath);
      
      expect(stats.size).to.be.greaterThan(1000);
    });

    it("Should have comprehensive analysis document", function () {
      const analysisPath = path.join(__dirname, "..", "GAIX_Scam_Analysis.md");
      const stats = fs.statSync(analysisPath);
      
      expect(stats.size).to.be.greaterThan(5000);
    });

    it("Should have proper file encoding", function () {
      const contractPath = path.join(__dirname, "..", "contracts", "GAIX.sol");
      const content = fs.readFileSync(contractPath, "utf8");
      
      // Should not have encoding errors
      expect(content).to.not.include("�");
    });
  });
});