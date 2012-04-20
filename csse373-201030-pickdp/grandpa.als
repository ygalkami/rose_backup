module language/grandpa

abstract sig Person {
	father: lone Man,
	mother: lone Woman
}

sig Man extends Person {
	wife: lone Woman
}

sig Woman extends Person {
	husband: lone Man
}

run {} for 3

fact Biology {
	no p: Person | p in p.^(mother + father)
}

fact Terminology {
	wife = ~husband
}

assert NoSelfFather {
	no m: Man | m = m.father
}
check NoSelfFather

fun grandpas[p: Person]: set Person {
	//biological: p.(mother + father).father
	let parent = mother + father + father.wife + mother.husband |
	p.parent.parent & Man
}

pred ownGrandpa[p: Person] {
	p in grandpas[p]
}
run ownGrandpa for 4 Person

fact SocialConvention {
	let biologicalParent = mother + father, spouse = husband + wife |
		no spouse & ^biologicalParent
}
