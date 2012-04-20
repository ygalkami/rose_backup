// Problem A.1.10
// Written by David Pick
module homework/hw3_3

abstract sig Name {
  address: set Addr + Name
}

sig Alias, Group extends Name {}
sig Addr {}

// invariants
fact {
  // Put your answers to a and b here, plus the 
  // additional invariant noted below.

  	//there is no name, that has itself in the address 
	all n: Name | not n in n.^address

	//all names eventually map to an address
	//All names (in the domain of the address relation) eventually map to an address.
	all n: address.univ |
		one a: Addr |
			a in n.^address

    //alias's must map to only 1 address or name
	all a: Alias | #a.^address < 2
}

// simulation constraints
pred show[] {
  // Put your answers to c and d here.
  
  // You may want to add additional constraints to make 
  // the generated instances more interesting.

  //the address book has at least two levels.
  //a name must be connected to a name, which is then connected to
  //either another name or and address
  some n1, n2: Name, a: Addr | n1->n2 in address and n2->a in address

  //some groups are non-empty
  some g: Group | some g.address
  some g: Group | no g.address
  //Group.address :> Name
  //
  //Alias.^address
}

run show for 3 but 6 Name
