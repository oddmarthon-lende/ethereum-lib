pragma solidity ^0.4.15;

library LinkedList {

   struct Link {

     uint id;
     uint ref;
     uint _nextId;
     uint _prevId;

   }

   struct List {

     uint _head;
     uint _tail;
     uint length;
     mapping(uint => Link) _data;
     uint _currentId;

   }

   function removal(
     List storage list,
     Link storage node
     ) internal {

       assert(list.length > 0);

       if(list._data[node.id].id > 0) {

          list.length--;
          delete list._data[node.id];

       }

     }

     function insertion(
       List storage list,
       Link memory link) internal returns (Link storage) {

         link.id = ++list._currentId;

         list._data[link.id] = link;
         list.length++;

         return list._data[link.id];

       }

       function get(List storage list, uint id) internal constant returns (Link storage) {
         return list._data[id];
       }

       function head(List storage list) internal constant returns (Link storage) {
         return list._data[list._head];
       }

       function tail(List storage list) internal constant returns (Link storage) {
         return list._data[list._tail];
       }

       function next(Link storage node, List storage list) internal constant returns (Link storage) {
         return list._data[node._nextId];
       }

       function previous(Link storage node, List storage list) internal constant returns (Link storage) {
         return list._data[node._prevId];
       }

       function insertAfter(
         List storage list,
         Link storage node, Link memory newNode) internal {

           Link storage nn = insertion(list, newNode);

           if(node._nextId == 0) {

             nn._nextId = 0;
             nn._prevId = node.id;

             list._tail = newNode.id;

           }
           else {

             nn._nextId = node._nextId;
             list._data[node._nextId]._prevId = nn.id;

           }

           node._nextId = nn.id;



         }

         function insertBefore(
           List storage list,
           Link storage node, Link memory newNode) internal {

             Link storage nn = insertion(list, newNode);

             nn._nextId = node.id;

             if(node._prevId == 0) {
               nn._prevId = 0;
               list._head = newNode.id;
             }
             else {
               nn._prevId = node._prevId;
               list._data[node._prevId]._nextId = nn.id;
             }

             node._prevId = nn.id;


           }

          function insertBeginning(
            List storage list,
            Link memory newNode) internal {

              if(list._head == 0) {

                Link storage nn = insertion(list, newNode);

                list._head = nn.id;
                list._tail = nn.id;

                nn._prevId = 0;
                nn._nextId = 0;

              }
              else {
                insertBefore(list, head(list), newNode);
              }

          }

          function insertEnd(
            List storage list,
            Link memory newNode) internal {

                 if(list._tail == 0) {
                   insertBeginning(list, newNode);
                 }
                 else {
                   insertAfter(list, tail(list), newNode);
                 }

          }

          function remove(
            List storage list,
            Link storage node) internal {

              if(node._prevId == 0) {
                list._head = list._data[node._nextId].id;
              }
              else {
                list._data[node._prevId]._nextId = node._nextId;
              }

              if(node._nextId == 0) {
                list._tail = list._data[node._prevId].id;
              }
              else {
                list._data[node._nextId]._prevId = node._prevId;
              }

              removal(list, node);

          }

          function push(List storage list, uint ref) internal returns (Link storage) {
            Link memory link = Link(0, ref, 0, 0);
            insertEnd(list, link);
            return list._data[link.id];
          }


}
