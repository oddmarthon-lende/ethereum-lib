pragma solidity ^0.4.15;

contract Owned {

  address internal owner;

  function Owned() public {
    owner = msg.sender;
  }

  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

  function kill() public onlyOwner {
    selfdestruct(owner);
  }

}
