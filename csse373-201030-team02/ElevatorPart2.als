module project/liftPrelimT

/*******************************************************
	This specification models a basic elevator (lift).  
	
	The lift has a set of buttons, one for each floor.  The buttons
	illuminate when pressed and cause the lift to visit the coresponding
	floor.  The illumination is cancelled when the corresponding floor
	is visited.
	
	The lift has two arrows indicating future direction.  One arrow is
	illuminated as the doors open.  The illumination is cancelled as the
	doors close.

	This version of the model uses an explicit notion of time.
 *******************************************************/

// Imposes a total ordering on floors
open util/ordering[Floor] as FO
// Imposes a total ordering on time instances
open util/ordering[Time] as TO

/*******************************************************
	Signatures of the meta-model
 *******************************************************/
// Just one lift for the first milestone
sig Lift {
	// The location of the lift; each lift can only be on one floor 
	// (until quantum elevatation is perfected):
	floor: Time -> one Floor,

	// The set of pending requests from inside the lift; also represents
	// the lights associated with the request buttons
	inLiftRequests: Time -> set Floor,

	// The direction indicator arrows inside the lift; absence
	// of a mapping indicates that the lights are off:
	dirIndicator: Time -> lone Dir,

	// The planned direction of the lift; absence of a mapping
	// indicates that the lift has no plans:
	plannedDirection: Time -> lone Dir,

	// The state of the lift's doors:
	doors: Time -> one DoorState,

	//Set of Up requests for this elevator
	outUpLiftRequests: Time -> set Floor,

	//Set of down requests for this elevator
	outDownLiftRequests: Time -> set Floor,

	//Is the elevator in service
	//this is a director because it is supposed to be a switch
	//If the switch is down the elevator is not in-service
	inService: Time-> one Dir
}
sig Floor {}

abstract sig Dir {}
one sig Up, Down extends Dir {}

abstract sig DoorState {}
one sig Open, Closed extends DoorState {}

sig Time {}

/*******************************************************
	Helper functions
 *******************************************************/

fun requestsPending[l: Lift, t: Time]: set Floor {
	// given as a function so requests from outside the lift
	// can be added later
	l.inLiftRequests[t]
}

//Return the set of up requests that are for the
//current floor or above
fun upRequestsAbove[l: Lift, t: Time]: set Floor {
	(nexts[l.floor[t]] + l.floor[t]) & l.outUpLiftRequests[t]
}

//Return the set of down requests that are for
//the current floor or below
fun downRequestsBelow[l: Lift, t: Time]: set Floor {
	(prevs[l.floor[t]] + l.floor[t]) & l.outDownLiftRequests[t]
}

//Return all requests on this floor or above
fun requestsAbove[l: Lift, t: Time]: set Floor {
	(nexts[l.floor[t]] + l.floor[t]) & (l.outUpLiftRequests[t] + l.outDownLiftRequests[t] + l.inLiftRequests[t])
}

//Return all requests on this floor or below
fun requestsBelow[l: Lift, t: Time]: set Floor {
	(prevs[l.floor[t]] + l.floor[t]) & (l.outUpLiftRequests[t] + l.outDownLiftRequests[t] + l.inLiftRequests[t])
}

/*******************************************************
	Facts and predicates constraining the system
 *******************************************************/

pred initTime[t: Time] {
	all l: Lift {
		l.floor[t] = first[]
		no l.requestsPending[t]
		l.doors[t] = Closed
		no l.plannedDirection[t]
		no l.dirIndicator[t]
		no l.outUpLiftRequests[t]
		no l.outDownLiftRequests[t]
		l.inService[t] = Up
	}
}

fact ValidTransitions {
	initTime[first[]]
	all t: Time - last[] |
		let t' = next[t] |
			someChange[t,t']
}

pred someChange[t, t': Time] {
	t != t'
	one l: Lift | {
		//If the elevator is in service, it can
		l.inService[t'] = Up => {
			(one d: Dir | l.move[t,t',d]) or //move
			(one d: Dir | l.changeService[t, t', d]) or //become out of service
			(one f: Floor | l.requestFloor[t,t',f]) or //get a in request
			(one f: Floor | l.outUpRequestFloor[t, t', f]) or //get an out up request
			(one f: Floor | l.outDownRequestFloor[t, t', f]) or //get an out down request
			l.openDoors[t,t'] or //open the doors
			l.closeDoors[t,t'] //close the doors
		 }
		// CONSIDER: nice way to represent this cross-cutting concern
		l.inService[t'] = Down => { //the elevator is not in service
			l.floor[t'] = l.floor[t]
			no l.requestsPending[t']
			l.doors[t'] = Closed
			no l.plannedDirection[t']
			no l.dirIndicator[t']
			no l.outUpLiftRequests[t']
			no l.outDownLiftRequests[t']
		} 
	}
}

pred noFloorChangeExcept[t,t': Time, ls: set Lift] {
	all l: (Lift - ls) | l.floor[t'] = l.floor[t]
	all l: ls | (let cf = l.floor[t] | l.floor[t'] in cf + next[cf] + prev[cf])
}

pred noRequestChangeExcept[t,t': Time, ls: set Lift] {
	all l: (Lift - ls) | l.inLiftRequests[t'] = l.inLiftRequests[t]
}

pred noDirIndicatorChangeExcept[t,t': Time, ls: set Lift] {
	all l: (Lift - ls) | l.dirIndicator[t'] = l.dirIndicator[t]
}

pred noPlannedDirChangeExcept[t,t': Time, ls: set Lift] {
	all l: (Lift - ls) | l.plannedDirection[t'] = l.plannedDirection[t]
}

pred noDoorChangeExcept[t,t': Time, ls: set Lift] {
	all l: (Lift - ls) | l.doors[t'] = l.doors[t]
}

pred noOutUpRequestChangeExcept[t, t':Time, ls: set Lift] {
	all l: (Lift - ls) | l.outUpLiftRequests[t'] = l.outUpLiftRequests[t]
}

pred noOutDownRequestChangeExcept[t, t': Time, ls: set Lift] {
	all l: (Lift - ls) | l.outDownLiftRequests[t'] = l.outDownLiftRequests[t]
} 


/*******************************************************
	Properties that we wish to have hold for the system
 *******************************************************/

pred ValidIndicators[t: Time] {
	all l: Lift {
		l.doors[t] = Closed => 
			no l.dirIndicator[t]
		l.doors[t] = Open =>
			(l.dirIndicator[t] = l.plannedDirection[t])
	}
}

pred ValidRequestLights[t: Time] {
	all l: Lift {
		l.doors[t] = Open => l.floor[t] not in l.inLiftRequests[t]
		l.doors[t] = Open and l.plannedDirection[t] = Up => l.floor[t] not in l.outUpLiftRequests[t]
		l.doors[t] = Open and l.plannedDirection[t] = Down => l.floor[t] not in l.outDownLiftRequests[t]
	}
}

pred Valid[t: Time] {
	ValidIndicators[t] and ValidRequestLights[t]
}

/*******************************************************
	Operation predicates
 *******************************************************/
// Models moving up or down one floor
pred Lift.move[t,t': Time, d: Dir] {
	// Can only move if the doors are closed:
	this.doors[t] = Closed
	let currentFloor = this.floor[t] {
		//if we were moving up and there's more requests above us, we should keep moving up
		this.plannedDirection[t] = Up and some upRequestsAbove[this, t] => {
			currentFloor != last[]
			this.floor[t'] = next[currentFloor]
			this.plannedDirection[t'] = Up
		}
		//if we were moving down and there are more requests below us, we should keep moving down
		this.plannedDirection[t] = Down and some downRequestsBelow[this, t] => {
			currentFloor != first[]
			this.floor[t'] = prev[currentFloor]
			this.plannedDirection[t'] = Down
		}
		// CONSIDER: using a predicate to set planned direction would be more re-useful

		//if there was no previous directions, move towards requests
		this.plannedDirection[t] = none and some requestsAbove[this, t] => { this.plannedDirection[t'] = Up }
		this.plannedDirection[t] = none and some requestsBelow[this, t] => { this.plannedDirection[t'] = Down }

		//otherwise move up or down
		d = Up => {
			currentFloor != last[]
			this.floor[t'] = next[currentFloor]
			this.plannedDirection[t'] = Up
		}

		d = Down => {
			currentFloor != first[]
			this.floor[t'] = prev[currentFloor]
			this.plannedDirection[t'] = Down
		}
	}
	noFloorChangeExcept[t,t',this]
	noOutUpRequestChangeExcept[t, t', none]
	noOutDownRequestChangeExcept[t, t', none]
	noRequestChangeExcept[t,t',none]
	noDirIndicatorChangeExcept[t,t',none]
	// The lift can change planned direction after completing a move
	noPlannedDirChangeExcept[t,t',this]
	noDoorChangeExcept[t,t',none]
}

pred Lift.changeService[t, t': Time, d: Dir] {
	noFloorChangeExcept[t,t',none]
	noRequestChangeExcept[t,t',this]
	noOutUpRequestChangeExcept[t, t', this]
	noOutDownRequestChangeExcept[t, t', this]
	noDirIndicatorChangeExcept[t,t',this]
	noPlannedDirChangeExcept[t,t',this]
	noDoorChangeExcept[t,t',this]
}

// Models a floor request from inside the lift
pred Lift.requestFloor[t,t': Time, f: Floor] {
	// Can't request the floor you are currently on:
	not (f = this.floor[t] and this.doors[t] = Open)
	this.inLiftRequests[t'] = this.inLiftRequests[t] + f
	noFloorChangeExcept[t,t',none]
	noRequestChangeExcept[t,t',this]
	noOutUpRequestChangeExcept[t, t', none]
	noOutDownRequestChangeExcept[t, t', none]
	noDirIndicatorChangeExcept[t,t',none]
	// CONSIDER: need to be able to change planned directon from stopped on a
	// new request
	noPlannedDirChangeExcept[t,t',none]
	noDoorChangeExcept[t,t',none]
}

pred Lift.outUpRequestFloor[t, t': Time, f: Floor] {
	not (f = this.floor[t] and this.doors[t] = Open)
	this.outUpLiftRequests[t'] = this.outUpLiftRequests[t] + f
	noOutUpRequestChangeExcept[t, t', this]
	noOutDownRequestChangeExcept[t, t', none]
	noFloorChangeExcept[t,t',none]
	noRequestChangeExcept[t,t',none]
	noDirIndicatorChangeExcept[t,t',none]
	// CONSIDER: need to be able to change planned directon from stopped on a
	// new request
	noPlannedDirChangeExcept[t,t',none]
	noDoorChangeExcept[t,t',none]
}

pred Lift.outDownRequestFloor[t, t': Time, f: Floor] {
	not (f = this.floor[t] and this.doors[t] = Open)
	this.outDownLiftRequests[t'] = this.outDownLiftRequests[t] + f
	noOutUpRequestChangeExcept[t, t', none]
	noOutDownRequestChangeExcept[t, t', this]
	noFloorChangeExcept[t,t',none]
	noRequestChangeExcept[t,t',none]
	noDirIndicatorChangeExcept[t,t',none]
	// CONSIDER: need to be able to change planned directon from stopped on a
	// new request
	noPlannedDirChangeExcept[t,t',none]
	noDoorChangeExcept[t,t',none]
}

// Models arriving at a floor, where "arrival" denotes the
// opening of the doors on the given floor.
pred Lift.openDoors[t,t': Time] {
	//only open the doors if the floor were on was requested
	((this.floor[t] in this.inLiftRequests[t]) or (this.floor[t] in this.outUpLiftRequests[t]) or (this.floor[t] in this.outDownLiftRequests[t]))
	//remove current floor from set of requests
	this.inLiftRequests[t'] = this.inLiftRequests[t] - this.floor[t]
	this.plannedDirection[t] = Up => this.outUpLiftRequests[t'] = this.outUpLiftRequests[t] - this.floor[t]
	this.plannedDirection[t] = Down => this.outDownLiftRequests[t'] = this.outDownLiftRequests[t] - this.floor[t]
	this.doors[t'] = Open
	this.dirIndicator[t'] = this.plannedDirection[t']
	noFloorChangeExcept[t,t',none]
	noRequestChangeExcept[t,t',this]
	noDirIndicatorChangeExcept[t,t',this]
	noPlannedDirChangeExcept[t,t',none]
	noDoorChangeExcept[t,t',this]
	noOutUpRequestChangeExcept[t, t', this]
	noOutDownRequestChangeExcept[t, t', this]
}

// Models closing the doors
pred Lift.closeDoors[t,t': Time] {
	this.doors[t'] = Closed
	no this.dirIndicator[t']
	noFloorChangeExcept[t,t',none]
	noRequestChangeExcept[t,t',none]
	noDirIndicatorChangeExcept[t,t',this]
	noPlannedDirChangeExcept[t,t',none]
	noDoorChangeExcept[t,t',this]
	noOutUpRequestChangeExcept[t, t', none]
	noOutDownRequestChangeExcept[t, t', none]
}

/*******************************************************
	Here are assertions about the correctness of the model.
 *******************************************************/

// Checks that all allowed state transitions maintain the
// validity constraints.
assert OnlyValid {
	all t: Time |
		let t' = next[t] |
			Valid[t] => Valid[t']
}
check OnlyValid for 5 but exactly 5 Floor, 25 Time

// CONSIDER: You can separately relate the pre- and 
// post-states by operations, as below, to narrow the scope 
// of scenarios.  That is, if the following fails, then we
// know move[] is the problem.
assert OnlyValid_Move {
	all t: Time|
		let t' = next[t] |
			all d: Dir, l: Lift |
				Valid[t] and l.move[t,t',d] => Valid[t']
}
check OnlyValid_Move for 5 but 2 Time

assert OnlyValid_Open {
	all t: Time |
		let t' = next[t] |
			all l: Lift |
				Valid[t] and l.openDoors[t,t'] => ValidIndicators[t']
}
check OnlyValid_Open for 5 but 2 Time

/*******************************************************
	Here are some predicates and commands for viewing sample
	instances.
 *******************************************************/
// A basic 'show' predicate for viewing instances
pred show[] {}
run show for 5 but exactly 5 Floor, exactly 3 Lift

// A predicate for showing interesting moves
pred showMove[t, t': Time, l: Lift] {
	t != t'
	one d: Dir | l.move[t,t',d]
}
run showMove for 3 but exactly 5 Floor, exactly 2 Time

// A predicate for showing interesting floor requests
pred showRequest[t,t': Time, l: Lift, f: Floor] {
	t != t'
	l.requestFloor[t,t',f]
}
run showRequest for 3 but exactly 5 Floor, exactly 25 Time

// A predicate for showing interesting arrivals
pred showOpenDoors[t,t': Time, l: Lift] {
	t != t'
	l.openDoors[t,t']
}
run showOpenDoors for 3 but exactly 5 Floor, exactly 2 Time
