pragma solidity ^0.5.0;

import './Destroyable.sol';
import './Stoppable.sol';

contract NaiveSplitter is Stoppable, Destroyable {

    mapping(address => uint) private ownedMoney;
    address public owner;

    event LogMoneyTransfering(uint amount, address to);
    event LogSplitFunds (address sender, uint amount, address firstReceiver, address secondReceiver);


    constructor() public {
        owner = msg.sender;
    }

    function withdrawFunds() public {
        require(ownedMoney [msg.sender] > 0);
        emit LogMoneyTransfering(ownedMoney[msg.sender], msg.sender);
        msg.sender.transfer(ownedMoney[msg.sender]);
        ownedMoney[msg.sender] = 0;
    }

    function splitFunds(address first, address second) onlyIfRunning public payable returns (bool success) {
        require(first != 0 && second != 0);
        require(msg.value > 0);
        //Since we can have the remainder of the division, I think it's better to operate with the balance of the contract itself.Sooner or later, the sum will be even.
        uint256 amount = this.balance / 2;
        ownedMoney [first] += amount;
        ownedMoney [second] += amount;
        emit LogSplitFunds(msg.sender, amount, first, second);
        return true;
    }
}
