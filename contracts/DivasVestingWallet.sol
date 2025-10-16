// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TaleVestingWallet is Ownable {
    using SafeERC20 for IERC20;

    address public token;
    address public beneficiary;
    uint256 public startTimestamp;
    uint256 public interval; // seconds between releases
    uint256 public releaseMonths; // total number of releases
    uint256 public totalAmount;

    uint256 public releasedAmount;
    uint256 public releasedTimes;

    event Released(uint256 amount, uint256 time);
    event EmergencyWithdraw(address to, uint256 amount);

    constructor(
        address _token,
        address _beneficiary,
        uint256 _startTimestamp,
        uint256 _interval,
        uint256 _releaseMonths,
        uint256 _totalAmount
    ) {
        require(_token != address(0), "Invalid token");
        require(_beneficiary != address(0), "Invalid beneficiary");
        require(_startTimestamp >= block.timestamp, "Start must be >= now");
        token = _token;
        beneficiary = _beneficiary;
        startTimestamp = _startTimestamp;
        interval = _interval;
        releaseMonths = _releaseMonths;
        totalAmount = _totalAmount;
    }

    function releasableAmount() public view returns (uint256) {
        if (block.timestamp < startTimestamp) return 0;
        uint256 elapsed = block.timestamp - startTimestamp;
        uint256 slots = elapsed / interval;
        if (slots > releaseMonths) slots = releaseMonths;
        uint256 amountPerSlot = totalAmount / releaseMonths;
        uint256 shouldHave = amountPerSlot * slots;
        if (shouldHave <= releasedAmount) return 0;
        return shouldHave - releasedAmount;
    }

    function release() external {
        uint256 amount = releasableAmount();
        require(amount > 0, "No releasable tokens");
        releasedAmount += amount;
        releasedTimes += 1;
        IERC20(token).safeTransfer(beneficiary, amount);
        emit Released(amount, block.timestamp);
    }

    function emergencyWithdraw(address to) external onlyOwner {
        uint256 bal = IERC20(token).balanceOf(address(this));
        if (bal > 0) {
            IERC20(token).safeTransfer(to, bal);
            emit EmergencyWithdraw(to, bal);
        }
    }
}
