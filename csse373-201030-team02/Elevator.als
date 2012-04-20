module elevator/main
open util/ordering[Floor]
open util/ordering[Time]

--------------------------------------------------
-- Signatures
--------------------------------------------------
sig Floor {}
sig Time {}
abstract sig DoorState{}
abstract sig Direction{}
one sig Open, Closed extends DoorState {}
one sig Up, Down extends Direction {}
sig Lift{
	door: Time -> one DoorState,
	//up and down arrows are never both on
	arrowLit: Time -> lone Direction,
	currentFloor: Time -> one Floor,
	requests: Time -> Floor
}


--------------------------------------------------
-- Assertions
--------------------------------------------------

assert requestsServiced {
	//Check to see if the next floor is requested
	//and then it is removed from the set of requested floors
	all t1, t2: Time, l: Lift |
		l.currentFloor[t2] in l.requests[t1] implies
			l.currentFloor[t2] not in l.requests[t2]
}
check requestsServiced

--------------------------------------------------
-- Facts
--------------------------------------------------

fact doorAlwaysOpen {
	//The elevator door is always open
	//since we are always on a floor
	all t: Time | Lift.door[t] = Open
}

fact floorDoesNotChangeRequestsDoNotChange{
	//If the floor from t1 to t2 does not change
	//the set of requests should also not change
	all t1, t2: Time, l: Lift |
		l.currentFloor[t1] = l.currentFloor[t2] implies
			l.requests[t1] = l.requests[t2] 
}

fact requestsCannotChange {
	//If the floor changes from t1 to t2 and
	//neither floor is in the requests set
	//make sure that the requests set does not change
	//from t1 to t2
	all t1, t2: Time, l: Lift |
		l.currentFloor[t1] != l.currentFloor[t2] and
			l.currentFloor[t1] not in l.requests[t1] and
				l.currentFloor[t2] not in l.requests[t2] implies
					l.requests[t1] = l.requests[t2]
}

fact mustBeAValidTransition {
	//The elevator can either move up or and down
	//and if it hits a requested floor, that one is
	//removed from the requests set
	all t1, t2: Time, l: Lift |
		validTransition[t1, t2, l]
}

fact cannotBeOnRequestedFloor {
	//The floor your on can't be requested
	all t1: Time, l: Lift |
		l.currentFloor[t1] not in l.requests[t1] 
}

--------------------------------------------------
-- Predicates
--------------------------------------------------

pred validTransition [t, t': Time, l: Lift] {
	//If the floor changes from t to t'
	//ensure that it only went up or down 1 floor
	//and if the new floor was in the set of request
	//remove it from the set
	l.currentFloor[t'] != l.currentFloor[t] implies 
		(moveUp[t, t', l] or moveDown[t, t', l]) and serviceFloor[t, t', l]
}

pred serviceFloor [t, t': Time, l: Lift] {
	//if the current floor is in the set of requests
	//remove it from the set
	l.currentFloor[t'] in l.requests[t] implies 
		l.requests[t'] = l.requests[t] - l.currentFloor[t']
}

pred moveDown [t, t': Time, l: Lift] {
	//Move the lift down 1 floor
	l.currentFloor[t'] = next[l.currentFloor[t]]
}

pred moveUp [t, t': Time, l: Lift] {
	//Move the lift up 1 floor
	l.currentFloor[t'] = prev[l.currentFloor[t]]
}

--------------------------------------------------
-- Run
--------------------------------------------------

//run {} for exactly 1 Lift, exactly 5 Floor, exactly 25 Time, exactly 1 DoorState
//run validTransition for exactly 1 Lift, exactly 5 Floor, exactly 2 Time, exactly 1 DoorState

//run moveDown for exactly 1 Lift, exactly 5 Floor, exactly 2 Time, exactly 1 DoorState
//run moveUp for exactly 1 Lift, exactly 5 Floor, exactly 2 Time, exactly 1 DoorState
run {} for exactly 1 Lift, exactly 5 Floor, exactly 2 Time, exactly 1 DoorState

