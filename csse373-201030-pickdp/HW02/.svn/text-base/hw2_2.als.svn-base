module homework/hw02_2

sig Person { likes: set Person }

assert NewNonEmptinessOK {
  some likes iff 
    (some p1, p2: Person | p1->p2 in likes)
}
check NewNonEmptinessOK

//Transitive
assert NewTransitivenessOK {
  (likes.likes in likes) iff 
    (all p1, p2, p3: Person | p1->p2 in likes and p2->p3 in likes implies p1->p3 in likes)// replace constraint with your answer
}
check NewTransitivenessOK

//Irreflexive
assert NewIrreflexiveOK {
  (no iden & likes) iff 
    (all p1: Person | p1->p1 not in likes)   // replace constraint with your answer
}
check NewIrreflexiveOK

//Symmetric
assert NewSymmetricOK {
  (~likes in likes) iff 
    (all p1, p2: Person | p1->p2 in likes implies p2->p1 in likes)  // replace constraint with your answer
}
check NewSymmetricOK

//Functional
assert NewFunctionalOK {
  (~likes.likes in iden) iff 
    (all p1: Person | not #p1.likes > 1)  // replace constraint with your answer
}
check NewFunctionalOK

//Injective
assert NewInjectiveOK {
  (likes.~likes in iden) iff 
    (all p1: Person | not #p1.~likes > 1)  // replace constraint with your answer
}
check NewInjectiveOK

//Total
assert NewTotalOK {
  (Person in likes.Person) iff 
    (all p1: Person | p1 in likes.Person)  // replace constraint with your answer
}
check NewTotalOK

//Onto
assert NewOntoOK {
  (Person in Person.likes) iff 
    (all p1: Person | p1 in Person.likes)  // replace constraint with your answer
}
check NewOntoOK
