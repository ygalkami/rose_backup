// Problem A.1.4
//Written by David Pick
module homework/hw3_1

sig Thing {}

assert union {
  all s: set Thing, p, q: Thing->Thing |
    s.(p+q) = s.p + s.q
}
check union for 4

assert difference {
	all s: set Thing, p, q: Thing->Thing |
		s.(p - q) = s.p -s.q
}
check difference for 2

assert intersection {
	all s: set Thing, p, q: Thing->Thing |
		s.(p & q) = s.p & s.q
}
check intersection for 2
