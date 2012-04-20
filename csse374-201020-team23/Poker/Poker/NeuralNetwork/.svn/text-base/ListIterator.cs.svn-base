using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
    class ListIterator<T>
    {
        private LinkedList<T> List;
        private LinkedListNode<T> Node;
        private LinkedListNode<T> tmp;

        public ListIterator(LinkedList<T> list){
        	List=list;
            Node = list.First;
         //   tmp = Node;
        }
        public LinkedListNode<T> next(){
        	tmp = Node;
            Node = Node.Next;
        	return tmp;
        }
        public bool hasNext(){
          if (Node == null) { return false; }
        	/*if(Node.Next!=null){
        		return true;
        	}*/
        	return true;
        }
        public LinkedListNode<T> current()
        {
            return tmp;
        }
        public void reset()
        {
            this.Node = this.List.First;
        }

    }
}
