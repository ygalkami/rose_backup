// Problem A.1.5
//Written by David Pick
module homework/hw3_2

sig Node {}

//each node has 1 parent except for root node
//root node has no parent
//there is only 1 root node
//two nodes can't have the same children
//you can reach all nodes from the root node
//nodes can have 0 or more children
pred isTree[r: Node -> Node] {
	//one n1: Node |  n1->n1 in r //1 node without parent
	//two nodes can't have the same child
	all n1, n2: Node | n1->n2 in r implies not n2->n1 in r

	all n1, n2, n3: Node | 
		n1->n2 in ^r and n2->n3 in r implies not n3->n1 in r

	one n1: Node | no n2: Node | n2->n1 in r

	all n1: Node | lone n2: Node | n2->n1 in r
}

run isTree for 4
