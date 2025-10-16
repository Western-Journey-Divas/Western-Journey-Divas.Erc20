// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface DivasVestingWallet {
    function getVestingSchedule() external view returns (
        address token,
        address beneficiary,
        uint256 startTimestamp,
        uint256 interval,
        uint256 releaseMonths,
        uint256 totalAmount,
        uint256 releasedAmount,
        uint256 releasableAmount
    );
}
