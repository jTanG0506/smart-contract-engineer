// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EnumExamples {
    // Enum representing shipping status
    enum Status {
        // No shipping request
        None,
        Pending,
        Shipped,
        // Accepted by receiver
        Completed,
        // Rejected by receiver (damaged, wrong item, etc...)
        Rejected,
        // Canceled before shipped
        Canceled
    }

    Status public status;

    // Returns uint
    // None      - 0
    // Pending   - 1
    // Shipped   - 2
    // Completed - 3
    // Rejected  - 4
    // Canceled  - 5
    function get() external view returns (Status) {
        return status;
    }

    // Update
    function set(Status _status) external {
        status = _status;
    }

    // Update to a specific enum
    function cancel() external {
        status = Status.Canceled;
    }

    // Reset enum to it's default value, 0
    function reset() public {
        delete status;
    }

    function ship() public {
        status = Status.Shipped;
    }
}
