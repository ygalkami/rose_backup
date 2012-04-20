module language/scope

//model file system with directories and aliases

abstract sig Object {}
sig Directory extends Object {
	contents: set Object
}
sig File extends Object {}
sig Alias extends File {
	to: Object
}

fact Hierarchy {
	// No object where we can start with that object and
	// and get back to it by following contents.
	//no o: Object | o in o.^contents
	all o: Object | o not in o.^contents

	//every object only "iives" in 1 directory
	all o: Object | lone contents.o
}

fact AllFilesInDirs {
	all f: File | some contents.f 
}

fact InterestingModel {
	some contents
//	some o1, o2, o3: Object | 
//		o1->o2 in contents and o2->o3 in contents and
//			o3->o1 in contents
}

run {} for 4
