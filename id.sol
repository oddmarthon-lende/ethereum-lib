pragma solidity ^0.4.15;

contract Id {

   uint private id;

   /*

    Generate a new id

    returns the new id

   */
   function generateId() internal returns (uint) {
     return ++id;
   }

}
