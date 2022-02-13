// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.11;

interface BEP20 {
    function totalSupply() external view returns (uint256);

    function decimals() external view returns (uint8);

    function symbol() external view returns (string memory);

    function name() external view returns (string memory);

    function getOwner() external view returns (address);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function allowance(address _owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

contract MyToken is BEP20 {
    uint256 public totalSupply = 100000000 * 10**10;
    uint8 public decimals = 10;
    string public symbol = "MT";
    string public name = "MyToken";

    address private _tokenOwner;
    mapping(address => uint256) private _balance;
    mapping(address => mapping(address => uint256)) private _allowances;

    constructor() {
        _tokenOwner = msg.sender;
        _balance[_tokenOwner] = totalSupply;
    }

    function getOwner() external view returns (address) {
        return _tokenOwner;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balance[account];
    }

    function transfer(address recipient, uint256 amount)
        external
        returns (bool)
    {
        _balance[msg.sender] -= amount;
        _balance[recipient] += amount;

        emit Transfer(msg.sender, recipient, amount);

        return true;
    }

    function allowance(address _owner, address spender)
        external
        view
        returns (uint256)
    {
        return _allowances[_owner][spender];
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        _allowances[msg.sender][spender] = amount;

        emit Approval(msg.sender, spender, amount);

        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        _allowances[sender][msg.sender] -= amount;
        _balance[sender] -= amount;
        _balance[recipient] += amount;

        emit Transfer(sender, recipient, amount);

        return true;
    }
}
