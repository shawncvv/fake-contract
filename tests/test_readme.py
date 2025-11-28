#!/usr/bin/env python3
"""
Comprehensive test suite for README.md validation.

This test suite validates the structure, content, and integrity of the README.md file
in a DeFi scam contract analysis educational repository.
"""

import re
import os
import sys
import unittest
from pathlib import Path


class TestReadmeStructure(unittest.TestCase):
    """Test cases for README.md structural validation."""

    @classmethod
    def setUpClass(cls):
        """Load README.md content once for all tests."""
        readme_path = Path(__file__).parent.parent / 'README.md'
        with open(readme_path, 'r', encoding='utf-8') as f:
            cls.content = f.read()
            cls.lines = cls.content.split('\n')

    def test_file_exists(self):
        """Test that README.md exists in the repository root."""
        readme_path = Path(__file__).parent.parent / 'README.md'
        self.assertTrue(readme_path.exists(), "README.md must exist in repository root")
        self.assertTrue(readme_path.is_file(), "README.md must be a file")

    def test_file_not_empty(self):
        """Test that README.md is not empty."""
        self.assertGreater(len(self.content), 0, "README.md must not be empty")
        self.assertGreater(len(self.lines), 1, "README.md must contain multiple lines")

    def test_utf8_encoding(self):
        """Test that README.md uses proper UTF-8 encoding for Chinese characters."""
        chinese_pattern = re.compile(r'[\u4e00-\u9fff]+')
        self.assertTrue(
            chinese_pattern.search(self.content),
            "README.md should contain Chinese characters"
        )
        self.assertIn('诈骗合约', self.content, "Should contain '诈骗合约' text")
        self.assertIn('教育目的', self.content, "Should contain '教育目的' text")

    def test_proper_line_endings(self):
        """Test that file doesn't have mixed line endings."""
        self.assertNotIn('\r', self.content, "File should use Unix line endings (LF only)")

    def test_ends_with_newline(self):
        """Test that file ends with a newline character."""
        self.assertTrue(
            self.content.endswith('\n') or self.content.endswith('\n\n'),
            "File should end with a newline character"
        )


class TestReadmeRequiredSections(unittest.TestCase):
    """Test cases for required sections in README.md."""

    @classmethod
    def setUpClass(cls):
        """Load README.md content once for all tests."""
        readme_path = Path(__file__).parent.parent / 'README.md'
        with open(readme_path, 'r', encoding='utf-8') as f:
            cls.content = f.read()

    def test_has_main_title(self):
        """Test that README has a main title (h1 header)."""
        h1_pattern = re.compile(r'^# .+', re.MULTILINE)
        matches = h1_pattern.findall(self.content)
        self.assertGreater(len(matches), 0, "README must have at least one h1 title")
        self.assertIn('# DeFi 诈骗合约分析与防御学习平台', self.content,
                      "Main title should be about DeFi scam analysis platform")

    def test_has_project_introduction(self):
        """Test that README contains a project introduction section."""
        self.assertIn('## 🎯 项目简介', self.content,
                      "README must have a project introduction section")

    def test_has_warning_section(self):
        """Test that README contains a warning/disclaimer section."""
        self.assertIn('## ⚠️ 重要声明', self.content,
                      "README must have a warning section")
        self.assertIn('仅用于教育目的', self.content,
                      "Must state educational purpose only")
        self.assertIn('严禁用于任何非法活动', self.content,
                      "Must warn against illegal activities")

    def test_has_directory_structure(self):
        """Test that README contains a directory structure section."""
        self.assertIn('## 📁 目录结构', self.content,
                      "README must have a directory structure section")
        self.assertIn('GAIX.sol', self.content,
                      "Directory structure should mention GAIX.sol")
        self.assertIn('GAIX_Scam_Analysis.md', self.content,
                      "Directory structure should mention analysis file")

    def test_has_analysis_objectives(self):
        """Test that README contains analysis objectives section."""
        self.assertIn('## 🔍 分析目标', self.content,
                      "README must have analysis objectives section")

    def test_has_target_audience(self):
        """Test that README contains target audience section."""
        self.assertIn('## 🎓 适用人群', self.content,
                      "README must have target audience section")

    def test_has_contribution_guide(self):
        """Test that README contains contribution guidelines."""
        self.assertIn('## 🤝 贡献指南', self.content,
                      "README must have contribution guidelines section")

    def test_has_legal_disclaimer(self):
        """Test that README contains a legal disclaimer."""
        self.assertIn('## ⚖️ 免责声明', self.content,
                      "README must have a legal disclaimer section")

    def test_multiple_warnings_present(self):
        """Test that README contains multiple warnings throughout."""
        warning_pattern = re.compile(r'⚠️|警告|声明|免责', re.IGNORECASE)
        matches = warning_pattern.findall(self.content)
        self.assertGreaterEqual(len(matches), 3,
                                "README should contain multiple warnings")


class TestReadmeContentValidation(unittest.TestCase):
    """Test cases for validating specific content in README.md."""

    @classmethod
    def setUpClass(cls):
        """Load README.md content once for all tests."""
        readme_path = Path(__file__).parent.parent / 'README.md'
        with open(readme_path, 'r', encoding='utf-8') as f:
            cls.content = f.read()

    def test_educational_purpose_emphasis(self):
        """Test that educational purpose is emphasized multiple times."""
        educational_mentions = self.content.lower().count('教育')
        self.assertGreaterEqual(educational_mentions, 3,
                                "Educational purpose should be mentioned at least 3 times")

    def test_no_investment_advice_warning(self):
        """Test that README explicitly states it's not investment advice."""
        self.assertIn('不构成投资建议', self.content,
                      "Must state that it's not investment advice")

    def test_no_interaction_warning(self):
        """Test that README warns against interacting with scam contracts."""
        self.assertIn('请勿', self.content, "Must contain 'do not' warnings")
        interaction_warning = ('请勿与任何诈骗合约进行交互' in self.content or
                              '请勿参与任何形式的投资' in self.content)
        self.assertTrue(interaction_warning,
                       "Must warn against interacting with scam contracts")

    def test_mentions_actual_files(self):
        """Test that README references the actual files in the repository."""
        self.assertIn('GAIX.sol', self.content,
                      "README should reference GAIX.sol")
        self.assertIn('GAIX_Scam_Analysis.md', self.content,
                      "README should reference GAIX_Scam_Analysis.md")

    def test_contains_emoji_indicators(self):
        """Test that README uses emoji for visual indicators."""
        emojis = ['🎯', '⚠️', '📁', '🔍', '🎓', '🤝', '⚖️']
        for emoji in emojis:
            self.assertIn(emoji, self.content,
                         f"README should contain emoji indicator: {emoji}")

    def test_target_audience_specificity(self):
        """Test that target audience section mentions specific groups."""
        target_groups = ['开发者', '研究员', '投资者', '学生']
        for group in target_groups:
            self.assertIn(group, self.content,
                         f"Target audience should mention: {group}")


class TestReadmeMarkdownSyntax(unittest.TestCase):
    """Test cases for validating markdown syntax in README.md."""

    @classmethod
    def setUpClass(cls):
        """Load README.md content once for all tests."""
        readme_path = Path(__file__).parent.parent / 'README.md'
        with open(readme_path, 'r', encoding='utf-8') as f:
            cls.content = f.read()
            cls.lines = cls.content.split('\n')

    def test_headers_have_space(self):
        """Test that headers have a space after the hash marks."""
        headers_without_space = re.compile(r'^#{1,6}[^\s]', re.MULTILINE)
        bad_headers = headers_without_space.findall(self.content)
        self.assertEqual(len(bad_headers), 0,
                        f"All headers should have space after #: {bad_headers}")

    def test_list_items_formatting(self):
        """Test that list items are properly formatted."""
        list_pattern = re.compile(r'^[\s]*[-*]\s+.+', re.MULTILINE)
        lists = list_pattern.findall(self.content)
        self.assertGreater(len(lists), 0, "README should contain list items")

    def test_bold_text_formatting(self):
        """Test that bold text uses proper markdown syntax."""
        bold_pattern = re.compile(r'\*\*.+?\*\*')
        bold_texts = bold_pattern.findall(self.content)
        self.assertGreater(len(bold_texts), 0, "README should contain bold text")

    def test_code_block_formatting(self):
        """Test that code blocks are properly formatted."""
        code_block_pattern = re.compile(r'```[\s\S]*?```', re.MULTILINE)
        code_blocks = code_block_pattern.findall(self.content)
        self.assertGreater(len(code_blocks), 0, "README should contain code blocks")

    def test_horizontal_rule_formatting(self):
        """Test that horizontal rules are properly formatted."""
        hr_pattern = re.compile(r'^---+\s*$', re.MULTILINE)
        hrs = hr_pattern.findall(self.content)
        self.assertGreater(len(hrs), 0, "README should contain horizontal rules")


class TestReadmeConsistency(unittest.TestCase):
    """Test cases for consistency between README and actual repository."""

    def setUp(self):
        """Set up test fixtures."""
        readme_path = Path(__file__).parent.parent / 'README.md'
        with open(readme_path, 'r', encoding='utf-8') as f:
            self.content = f.read()
        self.repo_root = Path(__file__).parent.parent

    def test_documented_files_exist(self):
        """Test that files mentioned in README actually exist."""
        mentioned_files = ['GAIX.sol', 'GAIX_Scam_Analysis.md', 'README.md']
        for filename in mentioned_files:
            file_path = self.repo_root / filename
            self.assertTrue(file_path.exists(),
                           f"File mentioned in README should exist: {filename}")

    def test_no_broken_internal_references(self):
        """Test that internal file references are valid."""
        if 'GAIX.sol' in self.content:
            gaix_path = self.repo_root / 'GAIX.sol'
            self.assertTrue(gaix_path.exists(),
                           "GAIX.sol referenced in README should exist")
        if 'GAIX_Scam_Analysis.md' in self.content:
            analysis_path = self.repo_root / 'GAIX_Scam_Analysis.md'
            self.assertTrue(analysis_path.exists(),
                           "GAIX_Scam_Analysis.md referenced in README should exist")


class TestReadmeSafetyCompliance(unittest.TestCase):
    """Test cases for ensuring README meets safety and ethical standards."""

    @classmethod
    def setUpClass(cls):
        """Load README.md content once for all tests."""
        readme_path = Path(__file__).parent.parent / 'README.md'
        with open(readme_path, 'r', encoding='utf-8') as f:
            cls.content = f.read()

    def test_no_promotion_of_illegal_activity(self):
        """Test that README doesn't promote illegal activities."""
        self.assertIn('严禁', self.content,
                      "Should explicitly prohibit illegal activities")
        self.assertIn('非法', self.content,
                      "Should mention illegal activities as prohibited")

    def test_educational_purpose_clear(self):
        """Test that educational purpose is clearly stated."""
        self.assertIn('教育目的', self.content,
                      "Educational purpose must be clearly stated")
        self.assertIn('学习', self.content,
                      "Learning purpose should be mentioned")

    def test_disclaimer_prominence(self):
        """Test that disclaimers are prominent."""
        self.assertIn('免责声明', self.content,
                      "Must have a disclaimer section")
        bold_warnings = re.findall(r'\*\*.*?警告.*?\*\*|\*\*.*?声明.*?\*\*', self.content, re.IGNORECASE)
        self.assertGreater(len(bold_warnings), 0,
                          "Warnings should be emphasized with bold text")

    def test_no_direct_contract_addresses(self):
        """Test that README doesn't contain Ethereum contract addresses."""
        eth_address_pattern = re.compile(r'0x[a-fA-F0-9]{40}')
        addresses = eth_address_pattern.findall(self.content)
        self.assertEqual(len(addresses), 0,
                        "README should not contain actual contract addresses")

    def test_risk_warnings_present(self):
        """Test that README contains adequate risk warnings."""
        risk_keywords = ['风险', '损失', '责任']
        found_risks = sum(1 for keyword in risk_keywords if keyword in self.content)
        self.assertGreaterEqual(found_risks, 2,
                                "Should contain multiple risk-related warnings")


class TestReadmeAccessibility(unittest.TestCase):
    """Test cases for README accessibility and readability."""

    @classmethod
    def setUpClass(cls):
        """Load README.md content once for all tests."""
        readme_path = Path(__file__).parent.parent / 'README.md'
        with open(readme_path, 'r', encoding='utf-8') as f:
            cls.content = f.read()

    def test_has_visual_indicators(self):
        """Test that README uses visual indicators (emojis) for scannability."""
        emoji_pattern = re.compile(r'[\U0001F300-\U0001F9FF]')
        emojis = emoji_pattern.findall(self.content)
        self.assertGreater(len(emojis), 5,
                          "Should use multiple emojis for visual indicators")

    def test_section_separation(self):
        """Test that sections are properly separated."""
        sections = re.findall(r'^## ', self.content, re.MULTILINE)
        self.assertGreaterEqual(len(sections), 6,
                                "Should have at least 6 main sections")

    def test_paragraph_spacing(self):
        """Test that paragraphs have proper spacing."""
        double_newlines = self.content.count('\n\n')
        self.assertGreater(double_newlines, 5,
                          "Should have adequate paragraph spacing")


if __name__ == '__main__':
    unittest.main(verbosity=2)