pragma solidity ^0.5.0;
import "./OwnableI.sol";

contract Destroyable is OwnableI {

  function destroy(address owner) onlyOwner public {
    selfdestruct(owner);
  }
}
