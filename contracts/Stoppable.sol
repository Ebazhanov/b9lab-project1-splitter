pragma solidity ^0.5.0;
import "./OwnableI.sol";

contract Stoppable is OwnableI {
    bool public stopped;

    event LogStopContract(bool, address);
    event LogResumeContract(bool, address);

    constructor () public {
        stopped = false;
    }

    function stopContract() public onlyOwner onlyIfRunning returns (bool success) {
        emit LogStopContract(true, msg.sender);
        stopped = true;
        return true;
    }

    function resumeContract() public onlyOwner onlyIfStopped returns (bool success) {
        emit LogResumeContract(true, msg.sender);
        stopped = false;
        return true;
    }

    modifier onlyIfRunning {
        require(!stopped);
        _;
    }
    modifier onlyIfStopped {
        require(stopped);
        _;
    }

}
