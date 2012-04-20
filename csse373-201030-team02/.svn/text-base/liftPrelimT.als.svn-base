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
one sig Lift {
	// The location of the lift; each lift can only be on one floor 
	// (until quantum elevatation is perfected):
	floor: Time -> one Floor,

	// The set of pending requests from inside the lift; also represents
	// the lights associated with the request buttons
	inLiftRequests: Time -> set Floor,

	//MINE
	// The set of pending requests from outside of the lift requesting a lift
	//	going up
	// also represents the lifts on the floors
	outUpLiftRequests: Time -> set Floor,

	//MINE
	// The set of pending requests from outside the lift requesting a lift
	// going down
	// also represents the lights on the floors
	outDownLiftRequests: Time -> set Floor,

	// The direction indicator arrows inside the lift; absence
	// of a mapping indicates that the lights are off:
	dirIndicator: Time -> lone Dir,

	// The planned direction of the lift; absence of a mapping
	// indicates that the lift has no plans:
	plannedDirection: Time -> lone Dir,

	// The state of the lift's doors:
	doors: Time -> one DoorState,

	inService: Time -> lone Service
}

sig Floor {}

sig Service{}
one sig On, Off extends Service {}

abstract sig Dir {}
one sig Up, Down extends Dir {}

abstract sig DoorState {}
one sig Open, Closed extends DoorState {}

sig Time {}

/*******************************************************
	Helper functions
 *******************************************************/

fun inRequestsPending[l: Lift, t: Time]: set Floor {
	// given as a function so requests from outside the lift
	// can be added later
	l.inLiftRequests[t]
}

//MINE
fun outDownRequestsPending[l: Lift, t: Time]: set Floor {
	l.outDownLiftRequests[t]
}

//MINE
fun outUpRequestsPending[l: Lift, t: Time]: set Floor {
	l.outUpLiftRequests[t]
}

/*******************************************************
	Facts and predicates constraining the system
 *******************************************************/

pred initTime[t: Time] {
	all l: Lift {
		l.floor[t] = first[]
		no l.inRequestsPending[t]
		//MINE
		no l.outDownRequestsPending[t]
		no l.outUpRequestsPending[t]
		l.doors[t] = Closed
		no l.plannedDirection[t]
		no l.dirIndicator[t]
	}
}

fact ValidTransitions {
	initTime[first[]]
	all t: Time - last[] |
		let t' = next[t] |
			someChange[t,t']
}

pred UpdatePlannedDirection[t, t': Time,  ls: set Lift] {
	t != t'
	all l: (Lift - ls) {
			let allOutRequests = (l.outDownLiftRequests[t] + l.outUpLiftRequests[t]) {
						 goUp[t, t', l] implies l.plannedDirection[t'] = Up else

						goDown[t, t', l] implies l.plannedDirection[t'] = Down else

						-- No previous planned direction and no requests so lets not go anywhere
						no l.plannedDirection[t] and no allOutRequests implies l.plannedDirection[t'] = none
		}
	}
}

pred goUp[t, t': Time, l: Lift] {
	let curFloor = l.floor[t] {
			let allOutRequests = (l.outDownLiftRequests[t] + l.outUpLiftRequests[t]) {
				let usAndAbove = curFloor + nexts[curFloor] {
						-- We were moving up and there is an up request above us, so continue moving up
						(some (usAndAbove & l.outUpLiftRequests[t]) and l.plannedDirection[t] = Up) or
						-- There is a request above us, and no requests below us, so go up
						some (nexts[curFloor] & allOutRequests) and no (prevs[curFloor] & allOutRequests) or
						-- The current floor is in the set of up requests, so it should plan to move up
						curFloor in l.outUpLiftRequests[t] or
						-- There was no previous planned direction, and there is a request above us so go up
						(no l.plannedDirection[t] and some (usAndAbove & allOutRequests))
					}
				}
	}
}

pred goDown[t, t': Time, l: Lift] {
	let curFloor = l.floor[t] {
			let allOutRequests = (l.outDownLiftRequests[t] + l.outUpLiftRequests[t]) {
					let usAndBelow = curFloor + prevs[curFloor] {
						-- We were moving down and there is a down request below us, so continue moving down
						(some (usAndBelow & l.outDownLiftRequests[t]) and l.plannedDirection[t] = Down) or
						-- There is a request below us, and no request above us, so go down
						some (prevs[curFloor] & allOutRequests) and no (nexts[curFloor] & allOutRequests) or
						-- The current floor is in the set of down requests, so it should plan to move down
						curFloor in l.outDownLiftRequests[t] or 
						-- There was no previous planned direction, and there is a request below us so go down	
						(no l.plannedDirection[t] and some (usAndBelow & allOutRequests))
					}
		}
	}
}

pred someChange[t, t': Time] {
	t != t'
	one l: Lift |
		(one d: Dir | l.move[t,t',d]) or
		(one f: Floor | l.requestFloor[t,t',f]) or
		//MINE
		(one f: Floor | l.outDownRequestFloor[t, t', f]) or
		(one f: Floor | l.outUpRequestFloor[t, t', f]) or
		(l.floor[t] in l.inLiftRequests[t] implies l.openDoors[t,t']) or
		l.closeDoors[t,t'] //or
//		l.inService[t, t']
}

pred noFloorChangeExcept[t,t': Time, ls: set Lift] {
	all l: (Lift - ls) | l.floor[t'] = l.floor[t]
	all l: ls | (let cf = l.floor[t] | l.floor[t'] in cf + next[cf] + prev[cf])
}

pred noInRequestChangeExcept[t,t': Time, ls: set Lift] {
	all l: (Lift - ls) | l.inLiftRequests[t'] = l.inLiftRequests[t]
}

//MINE
pred noOutDownRequestChangeExcept[t, t': Time, ls: set Lift] {
	all l: (Lift - ls) | l.outDownLiftRequests[t'] = l.outDownLiftRequests[t]
}

//MINE
pred noOutUpRequestChangeExcept[t, t': Time, ls: set Lift] {
	all l: (Lift - ls) | l.outUpLiftRequests[t'] = l.outUpLiftRequests[t]
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

pred noServiceChangeExcept[t, t': Time, ls: set Lift] {
	all l: (Lift - ls) | l.inService[t'] = l.inService[t]
}


/*******************************************************
	Properties that we wish to have hold for the system
 *******************************************************/

pred ValidIndicators[t: Time] {
	all l: Lift {
		l.doors[t] = Closed implies 
			no l.dirIndicator[t]
		l.doors[t] = Open implies
			(l.dirIndicator[t] = l.plannedDirection[t])
	}
}

pred ValidRequestLights[t: Time] {
	all l: Lift {
		l.doors[t] = Open implies 
			l.floor[t] not in l.inLiftRequests[t]
	}
}

pred ValidOutDownRequestLights[t: Time] {
	all l: Lift {
		l.doors[t] = Open and Down in l.plannedDirection[t] implies
			l.floor[t] not in l.outDownLiftRequests[t]
	}
}

pred ValidOutUpRequestLights[t: Time] {
	all l: Lift {
		l.doors[t] = Open and Up in l.plannedDirection[t] implies
			l.floor[t] not in l.outUpLiftRequests[t]
	}
}

pred Valid[t: Time] {
	ValidIndicators[t] and ValidRequestLights[t] and
		ValidOutUpRequestLights[t] and ValidOutDownRequestLights[t]
}

/*******************************************************
	Operation predicates
 *******************************************************/
// Models moving up or down one floor
pred Lift.move[t,t': Time, d: Dir] {
	// Can only move if the doors are closed:
	this.doors[t] = Closed
	let currentFloor = this.floor[t] {
		d = this.plannedDirection[t] and d = Up => {
			currentFloor != last[]
			this.floor[t'] = next[currentFloor]
		}
		d = this.plannedDirection[t] and d = Down => {
			currentFloor != first[]
			this.floor[t'] = prev[currentFloor]
		}
	}
	noFloorChangeExcept[t, t', this]
	noInRequestChangeExcept[t, t', none]
	noOutDownRequestChangeExcept[t, t', none]
	noOutUpRequestChangeExcept[t, t', none]
	noDirIndicatorChangeExcept[t, t', none]
	// The lift can change planned direction after completing a move
	noPlannedDirChangeExcept[t, t', none]
	UpdatePlannedDirection[t, t', none]
	noDoorChangeExcept[t, t', none]
	noServiceChangeExcept[t, t', none]
}

// Models a floor request from inside the lift
pred Lift.requestFloor[t,t': Time, f: Floor] {
	// Can't request the floor you are currently on:
	not (f = this.floor[t] and this.doors[t] = Open)
	this.inLiftRequests[t'] = this.inLiftRequests[t] + f
	noFloorChangeExcept[t,t',none]
	noInRequestChangeExcept[t,t',this]
	noOutDownRequestChangeExcept[t, t', none]
	noOutUpRequestChangeExcept[t, t', none]
	noDirIndicatorChangeExcept[t,t',none]
	noPlannedDirChangeExcept[t,t',none]
	UpdatePlannedDirection[t, t', none]
	noDoorChangeExcept[t,t',none]
	noServiceChangeExcept[t, t', none]
}

//MINE
// Models down request from outside the lift
pred Lift.outDownRequestFloor[t,t': Time, f: Floor] {
	// Can't request the floor you are currently on:
	not (f = this.floor[t] and this.doors[t] = Open)
	this.outDownLiftRequests[t'] = this.outDownLiftRequests[t] + f
	noFloorChangeExcept[t,t',none]
	noInRequestChangeExcept[t,t',none]
	noOutDownRequestChangeExcept[t, t', this]
	noOutUpRequestChangeExcept[t, t', none]
	noDirIndicatorChangeExcept[t,t',none]
	noPlannedDirChangeExcept[t,t', this]
	UpdatePlannedDirection[t, t', this]
	noDoorChangeExcept[t,t',none]
	noServiceChangeExcept[t, t', none]
}

//MINE
// Models up request from outside the lift
pred Lift.outUpRequestFloor[t,t': Time, f: Floor] {
	// Can't request the floor you are currently on:
	not (f = this.floor[t] and this.doors[t] = Open)
	this.outUpLiftRequests[t'] = this.outUpLiftRequests[t] + f
	noFloorChangeExcept[t,t',none]
	noInRequestChangeExcept[t,t',none]
	noOutDownRequestChangeExcept[t, t', none]
	noOutUpRequestChangeExcept[t, t', this]
	noDirIndicatorChangeExcept[t,t',none]
	noPlannedDirChangeExcept[t,t',this]
	UpdatePlannedDirection[t, t', this]
	noDoorChangeExcept[t,t',none]
	noServiceChangeExcept[t, t', none]
}

// Models arriving at a floor, where "arrival" denotes the
// opening of the doors on the given floor.
pred Lift.openDoors[t,t': Time] {
	// This next line is what is wrong... but why...
	this.floor[t] in this.inLiftRequests[t]

	this.inLiftRequests[t'] = this.inLiftRequests[t] - this.floor[t]
	this.plannedDirection[t] = Down => this.outDownLiftRequests[t'] = this.outDownLiftRequests[t] - this.floor[t]
	this.plannedDirection[t] = Up => this.outUpLiftRequests[t'] = this.outUpLiftRequests[t] - this.floor[t]
	this.doors[t'] = Open
	this.dirIndicator[t'] = this.plannedDirection[t']
	noFloorChangeExcept[t,t',none]
	noInRequestChangeExcept[t,t',none]
	noOutDownRequestChangeExcept[t, t', none]
	noOutUpRequestChangeExcept[t, t', none]
	noDirIndicatorChangeExcept[t,t',this]
	noPlannedDirChangeExcept[t,t',none]
	UpdatePlannedDirection[t, t', none]
	noDoorChangeExcept[t,t',this]
	noServiceChangeExcept[t, t', none]
}
	
// Models closing the doors
pred Lift.closeDoors[t,t': Time] {
	this.doors[t'] = Closed
	no this.dirIndicator[t']
	noFloorChangeExcept[t,t',none]
	noInRequestChangeExcept[t,t',none]
	noOutDownRequestChangeExcept[t, t', none]
	noOutUpRequestChangeExcept[t, t', none]
	noDirIndicatorChangeExcept[t,t',this]
	noPlannedDirChangeExcept[t,t',none]
	UpdatePlannedDirection[t, t', none]
	noDoorChangeExcept[t,t',this]
	noServiceChangeExcept[t, t', none]
}

pred Lift.inService[t, t': Time] {
	this.inLiftRequests[t'] = none
	this.outDownLiftRequests[t'] = none
	this.outUpLiftRequests[t'] = none
	this.doors[t'] = Closed
	this.dirIndicator[t'] = none
	this.plannedDirection[t'] = none
	this.inService[t'] = On
}

/*******************************************************
	Here are assertions about the correctness of the model.
 *******************************************************/

// Checks that all allowed state transitions maintain the
// validity constraints.
assert OnlyValid {
	Valid[first]
	all t: Time |
		let t' = next[t] | 
			Valid[t] => Valid[t']
}
check OnlyValid for 5 but exactly 5 Floor, 5 Time

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
				Valid[t] and l.openDoors[t,t'] implies ValidIndicators[t']
}
check OnlyValid_Open for 5 but 2 Time

/*******************************************************
	Here are some predicates and commands for viewing sample
	instances.
 *******************************************************/
// A basic 'show' predicate for viewing instances
pred show[] {}
run show for 3 but exactly 5 Floor

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
run showRequest for 3 but exactly 5 Floor, exactly 2 Time

pred showOutUpRequest[t, t': Time, l: Lift, f:Floor] {
	t != t'
	t' = next[t]
	l.outUpRequestFloor[t, t', f]
}
run showOutUpRequest for 3 but exactly 5 Floor, exactly 5 Time

// A predicate for showing interesting arrivals
pred showOpenDoors[t,t': Time, l: Lift] {
	t != t'
	l.openDoors[t,t']
}
run showOpenDoors for 3 but exactly 5 Floor, exactly 2 Time

// A predicate for showing sequences of operations
pred showTrace[] {
}
run showTrace for 3 but exactly 5 Floor, exactly 10 Time
