module homework/hw02_1

sig Person { likes: set Person }

fact {
	#Person >= 4
}

pred show {
  //some likes              -- nonempty 
  //likes.likes in likes    -- transitive
  //no iden & likes         -- irreflexive
  //~likes in likes         -- symmetric 
  //~likes.likes in iden    -- functional
  //likes.~likes in iden    -- injective
  //Person in likes.Person  -- total
  Person in Person.likes  -- onto
  }



run show for 4
