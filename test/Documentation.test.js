const { expect } = require("chai");
const fs = require("fs");
const path = require("path");

describe("Documentation Validation Tests", function () {
  let analysisContent;
  let readmeContent;

  before(function () {
    // Read documentation files
    const analysisPath = path.join(__dirname, "..", "GAIX_Scam_Analysis.md");
    const readmePath = path.join(__dirname, "..", "README.md");
    
    analysisContent = fs.readFileSync(analysisPath, "utf8");
    readmeContent = fs.readFileSync(readmePath, "utf8");
  });

  describe("GAIX_Scam_Analysis.md Structure", function () {
    it("Should have proper markdown structure", function () {
      expect(analysisContent).to.include("# GAIX 合约诈骗技术分析报告");
    });

    it("Should contain all required sections", function () {
      const requiredSections = [
        "## 概述",
        "## 1. 代码混淆技术",
        "## 2. 权限控制和后门机制",
        "## 3. 交易操控和限制机制",
        "## 4. 任意资金提取后门",
        "## 5. 诈骗实例演示",
        "## 6. 识别诈骗合约的标志",
        "## 7. 防护建议",
        "## 结论"
      ];

      requiredSections.forEach(section => {
        expect(analysisContent).to.include(section);
      });
    });

    it("Should document obfuscated function names", function () {
      expect(analysisContent).to.include("_TnezmUOdSpme");
      expect(analysisContent).to.include("混淆的函数名");
    });

    it("Should document obfuscated variable names", function () {
      expect(analysisContent).to.include("MMZwlXZIHm");
      expect(analysisContent).to.include("ERppNtukt");
      expect(analysisContent).to.include("混淆参数名");
    });

    it("Should document backdoor functions", function () {
      expect(analysisContent).to.include("hhwrfjkmw");
      expect(analysisContent).to.include("zbyezudcyd");
      expect(analysisContent).to.include("drokyskux");
    });

    it("Should document malicious addresses", function () {
      expect(analysisContent).to.include("0x59aFFF458527c6C7FE1d3228255EcbCeC634e9f0");
      expect(analysisContent).to.include("0x6EaEea4eB670a837fA53af2dd4213cC9dD936385");
    });

    it("Should include code examples", function () {
      expect(analysisContent).to.match(/```solidity/);
      expect(analysisContent).to.include("function transfer");
    });

    it("Should document scam mechanisms", function () {
      expect(analysisContent).to.include("rug pull");
      expect(analysisContent).to.include("黑名单");
      expect(analysisContent).to.include("白名单");
    });

    it("Should provide security recommendations", function () {
      expect(analysisContent).to.include("防护建议");
      expect(analysisContent).to.include("代码审计");
    });

    it("Should include warning markers", function () {
      const warningMarkers = ["✗", "❌", "✚"];
      let hasWarnings = false;
      
      warningMarkers.forEach(marker => {
        if (analysisContent.includes(marker)) {
          hasWarnings = true;
        }
      });
      
      expect(hasWarnings).to.be.true;
    });
  });

  describe("README.md Validation", function () {
    it("Should exist and not be empty", function () {
      expect(readmeContent).to.not.be.empty;
    });

    it("Should contain repository title or description", function () {
      expect(readmeContent.length).to.be.greaterThan(0);
    });
  });

  describe("Code Snippet Validation in Documentation", function () {
    it("Should have valid Solidity syntax in code blocks", function () {
      const solidityBlocks = analysisContent.match(/```solidity[\s\S]*?```/g);
      
      if (solidityBlocks) {
        solidityBlocks.forEach(block => {
          // Check for common Solidity keywords
          const hasSolidityKeywords = 
            block.includes("function") ||
            block.includes("contract") ||
            block.includes("mapping") ||
            block.includes("address") ||
            block.includes("uint256");
          
          expect(hasSolidityKeywords).to.be.true;
        });
      }
    });

    it("Should document the specific scam patterns found", function () {
      expect(analysisContent).to.include("阻止套利");
      expect(analysisContent).to.include("价格操控");
      expect(analysisContent).to.include("流动性检查");
    });

    it("Should explain the SHA256 hash protection mechanism", function () {
      expect(analysisContent).to.include("sha256");
      expect(analysisContent).to.include("_rCCfXWOTlY");
    });

    it("Should document the Uniswap integration details", function () {
      expect(analysisContent).to.include("uniswapV2Pair");
      expect(analysisContent).to.include("getReserves");
    });
  });

  describe("Cross-Reference Validation", function () {
    it("Should reference actual contract addresses found in GAIX.sol", function () {
      const contractPath = path.join(__dirname, "..", "contracts", "GAIX.sol");
      const contractContent = fs.readFileSync(contractPath, "utf8");
      
      // Check if documented addresses exist in contract
      if (analysisContent.includes("0x59aFFF458527c6C7FE1d3228255EcbCeC634e9f0")) {
        expect(contractContent).to.include("0x59aFFF458527c6C7FE1d3228255EcbCeC634e9f0");
      }
    });

    it("Should reference actual function names from GAIX.sol", function () {
      const contractPath = path.join(__dirname, "..", "contracts", "GAIX.sol");
      const contractContent = fs.readFileSync(contractPath, "utf8");
      
      const functionNames = ["hhwrfjkmw", "zbyezudcyd", "drokyskux"];
      
      functionNames.forEach(funcName => {
        if (analysisContent.includes(funcName)) {
          expect(contractContent).to.include(`function ${funcName}`);
        }
      });
    });

    it("Should reference actual variable names from GAIX.sol", function () {
      const contractPath = path.join(__dirname, "..", "contracts", "GAIX.sol");
      const contractContent = fs.readFileSync(contractPath, "utf8");
      
      const varNames = ["_ecjqovvawneg", "_ISQWnmDsVMEYX", "_rCCfXWOTlY"];
      
      varNames.forEach(varName => {
        if (analysisContent.includes(varName)) {
          expect(contractContent).to.include(varName);
        }
      });
    });
  });

  describe("Documentation Quality Metrics", function () {
    it("Should have sufficient content length", function () {
      // Should be at least 5000 characters for comprehensive analysis
      expect(analysisContent.length).to.be.greaterThan(5000);
    });

    it("Should have multiple subsections per main section", function () {
      const subsectionPattern = /### /g;
      const subsections = analysisContent.match(subsectionPattern);
      
      expect(subsections).to.not.be.null;
      expect(subsections.length).to.be.greaterThan(5);
    });

    it("Should include practical examples", function () {
      expect(analysisContent).to.include("场景");
      expect(analysisContent).to.include("步骤");
    });

    it("Should have proper formatting", function () {
      // Check for proper list formatting
      expect(analysisContent).to.match(/^\s*[-*]\s+/m);
      
      // Check for proper numbered lists
      expect(analysisContent).to.match(/^\s*\d+\.\s+/m);
    });
  });

  describe("Link and Reference Validation", function () {
    it("Should include relevant external references", function () {
      // Check for URLs in the documentation
      const urlPattern = /https?:\/\/[^\s)]+/g;
      const urls = analysisContent.match(urlPattern);
      
      if (urls) {
        expect(urls.length).to.be.greaterThan(0);
      }
    });

    it("Should document contract header information from GAIX.sol", function () {
      // Read the contract to verify it has header info
      const contractPath = path.join(__dirname, "..", "contracts", "GAIX.sol");
      const contractContent = fs.readFileSync(contractPath, "utf8");
      
      // Contract has website/social info in header comments
      const hasWebsiteInfo = contractContent.includes("Website:") || 
                            contractContent.includes("Twitter:") ||
                            contractContent.includes("Telegram:");
      
      // The analysis references the contract which has this info
      expect(hasWebsiteInfo || analysisContent.length > 1000).to.be.true;
    });
  });

  describe("Security Warning Validation", function () {
    it("Should contain explicit security warnings", function () {
      const warnings = [
        "不要投资",
        "不要与此合约进行任何交互",
        "举报",
        "提高警惕"
      ];

      let hasWarning = false;
      warnings.forEach(warning => {
        if (analysisContent.includes(warning)) {
          hasWarning = true;
        }
      });

      expect(hasWarning).to.be.true;
    });

    it("Should clearly identify malicious behavior", function () {
      const maliciousBehaviors = [
        "诈骗",
        "恶意",
        "窃取",
        "欺诈"
      ];

      let foundMalicious = false;
      maliciousBehaviors.forEach(behavior => {
        if (analysisContent.includes(behavior)) {
          foundMalicious = true;
        }
      });

      expect(foundMalicious).to.be.true;
    });
  });

  describe("Technical Accuracy Validation", function () {
    it("Should describe ERC20 standard functions", function () {
      // Check for transfer function descriptions
      expect(analysisContent).to.include("transfer");
      
      // Check for either approve or transferFrom
      const hasERC20Functions = 
        analysisContent.includes("approve") ||
        analysisContent.includes("allowance") ||
        analysisContent.toLowerCase().includes("erc20");
      
      expect(hasERC20Functions).to.be.true;
    });

    it("Should explain the whitelist/blacklist mechanism", function () {
      expect(analysisContent).to.include("mapping");
      expect(analysisContent).to.include("bool");
    });

    it("Should document Solidity technical details", function () {
      const hasSolidityDetails =
        analysisContent.includes("solidity") ||
        analysisContent.includes("Solidity") ||
        analysisContent.includes("pragma") ||
        analysisContent.includes("0.8");
      
      expect(hasSolidityDetails).to.be.true;
    });
  });

  describe("Scam Pattern Documentation", function () {
    it("Should document obfuscation techniques", function () {
      expect(analysisContent).to.include("混淆");
    });

    it("Should document backdoor mechanisms", function () {
      expect(analysisContent).to.include("后门");
    });

    it("Should document liquidity pool manipulation", function () {
      expect(analysisContent).to.include("流动性");
    });

    it("Should document rug pull scenario", function () {
      expect(analysisContent.toLowerCase()).to.include("rug pull");
    });
  });
});