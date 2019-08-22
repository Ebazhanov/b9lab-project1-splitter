pragma solidity ^0.5.0;

contract MigrationsI {
    address public owner;
    uint public last_completed_migration;

    modifier restricted() {
        if (msg.sender == owner) _;
    }

    function Migrations() public {
        owner = msg.sender;
    }

    function setCompleted(uint completed) public restricted {
        last_completed_migration = completed;
    }

    function upgrade(address new_address) public restricted {
        MigrationsI upgraded = Migrations(new_address);
        upgraded.setCompleted(last_completed_migration);
    }
}
