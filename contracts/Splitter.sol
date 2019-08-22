pragma solidity ^0.5.0;

import './Destroyable.sol';
import './Stoppable.sol';

contract Splitter is Destroyable, Stoppable {


  address public ownerAddress;
  address public secondAddress;
  address public thirdAddress;
  uint private amount;

  event LogSendMoneyToFirstAcc(uint);
  event LogSendMoneyToSecondAcc(uint);
  event LogSendMoneyToThirdAcc(uint);
  event LogCurrentAmount(uint);

  constructor(address address1,address address2, address address3) public  {
    require(address1 != 0);
    require(address2 != 0);
    require(address3 != 0);

    ownerAddress = address1;
    secondAddress = address2;
    thirdAddress = address3;
  }

  function sendMoneyToFirstAcc(uint money) private returns (bool){
    LogSendMoneyToFirstAcc(money);
    ownerAddress.transfer(money);

    return true;
  }

  function sendMoneyToSecAcc(uint money) private returns (bool){
    LogSendMoneyToSecondAcc(money);
    secondAddress.transfer(money);
    return true;
  }

  function sendMoneyToThirdAcc(uint money) private returns (bool){
    LogSendMoneyToThirdAcc(money);
    thirdAddress.transfer(money);
    return true;
  }


  function payMoney() public payable returns (bool) {
    require(msg.value > 0);
    //avoid 0 value transfers
    require(msg.sender.balance >= msg.value);
    //avoid overspending
    return true;
  }

  event Sum(uint);

  function divideMoney(uint tempSum) public payable returns (uint) {
    Sum(tempSum);
    amount = tempSum / 2;
    return amount;
  }


  function split() onlyIfRunning public returns (bool) {
    divideMoney(this.balance);
    LogCurrentAmount(amount);
    if (msg.sender == ownerAddress) {
      sendMoneyToSecAcc(amount);
      sendMoneyToThirdAcc(amount);
    } else if (msg.sender == secondAddress) {
      sendMoneyToFirstAcc(amount);
      sendMoneyToThirdAcc(amount);
    } else {
      sendMoneyToFirstAcc(amount);
      sendMoneyToSecAcc(amount);
    }
    return true;
  }
}
