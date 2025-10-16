// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TaleVestingWallet.sol";
import "./ITaleVestingWallet.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TaleVestingWalletFactory is Ownable {
    address public token;
    address[] public allVestingWallets;

    event VestingWalletCreated(address indexed wallet, address beneficiary);

    constructor(address _token) {
        require(_token != address(0), "Token required");
        token = _token;
    }

    function createVestingWallet(
        address _beneficiary,
        uint256 _startTimestamp,
        uint256 _interval,
        uint256 _releaseMonths,
        uint256 _totalAmount
    ) external onlyOwner returns (address) {
        TaleVestingWallet wallet = new TaleVestingWallet(
            token,
            _beneficiary,
            _startTimestamp,
            _interval,
            _releaseMonths,
            _totalAmount
        );
        allVestingWallets.push(address(wallet));
        emit VestingWalletCreated(address(wallet), _beneficiary);
        return address(wallet);
    }

    function getAllVestingWallets() external view returns (address[] memory) {
        return allVestingWallets;
    }
}
