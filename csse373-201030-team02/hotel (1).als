module chapter6/hotel

open util/ordering[Time] as TO
open util/ordering[Key] as KO

sig Key, Time {}

sig Room {
	keys: set Key,
	currentKey: keys one -> Time
}

/** Essentially global relations **/
one sig FrontDesk {
	lastKey: (Room -> lone Key) -> Time,
	occupant: (Room -> Guest) -> Time
}

sig Guest {
	keys: Key -> Time
}

-- No key may belong to more than one room lock.
fact UniqueRoomKeys {
	keys in Room lone -> Key
}

-- Model pseudo-random key generation
fun nextKey[k: Key, ks: set Key]: set Key {
	min[k.nexts & ks]
}

-- Define initial conditions
pred init[t: Time] {
	-- No guest have keys
	no Guest.keys.t
	-- No rooms are occupied
	no FrontDesk.occupant.t
	-- The record of last keys at the front desk matches the locks
	all r: Room | FrontDesk.lastKey.t[r] = r.currentKey.t
}

/** Define the events in the system **/
abstract sig Event {
	pre, post: Time,
	guest: Guest
}

abstract sig RoomKeyEvent extends Event {
	room: Room,
	key: Key
}

sig Entry extends RoomKeyEvent {} {
	-- this key belongs to this guest
	key in guest.keys.pre
	let ck = room.currentKey {
		-- either we're entering again and the lock doesn't change
		(key = ck.pre and ck.post = ck.pre) or
		-- this is the first time entering so the lock changes
		(key = nextKey[ck.pre, room.keys] and ck.post = key)
	}
	-- Finally, make sure no other changes to the currentKeys
	currentKey.post = currentKey.pre ++ room->key
}

pred showEntry[t, t': Time] {
	t' = next[t]
	one e: Entry | e.pre = t and e.post = t'
}
run showEntry for 2 but exactly 2 Time, 1 Event

sig CheckIn extends RoomKeyEvent {} {
	-- assigns a key to the guest
	keys.post = keys.pre + guest -> key
	let occ = FrontDesk.occupant {
		-- room must be empty
		no occ.pre[room]
		-- assign room to guest, keep others constant
		occ.post = occ.pre + room -> guest
	}
	let lk = FrontDesk.lastKey {
		-- records the new key for the room
		lk.post = lk.pre ++ room -> key
		-- correct next key for that room (kind of a precondition)
		key = nextKey[lk.pre[room], room.keys]
	}
}

pred showCheckin[t,t': Time] {
	t' = next[t]
	one e: CheckIn | e.pre = t and e.post = t'
}
run showCheckin for 2 but exactly 2 Time, 1 Event

sig CheckOut extends RoomKeyEvent {} {
	let occ = FrontDesk.occupant {
		-- Guest must have been an occupant of the room
		some occ.pre.guest
		-- Remove the guest from the occupants, but keep other
		-- occupants the same.
		occ.post = occ.pre - room->guest
	}
}

pred showCheckOut[t,t': Time] {
	t' = next[t]
	one e: CheckOut | e.pre = t and e.post = t'
}
run showCheckOut for 2 but exactly 2 Time, 1 Event

-- Tracks the progression of time
fact Traces {
	init[first]
	all t: Time - last {
		let t' = t.next {
			some e: Event {
				e.pre = t and e.post = t'
				-- If current key changed, someone entered a room
				currentKey.t != currentKey.t' => e in Entry
				-- If occupant changed, then someone checked in or out
				occupant.t != occupant.t' => e in (CheckIn + CheckOut)
				-- If assigned keys or last key changed, then it was
				-- a CheckIn
				(lastKey.t != lastKey.t' or keys.t != keys.t') =>
					e in CheckIn
			}
		}
	}
}

/**
	Check that model works.
**/
assert NoBadEntry {	
	all e: Entry |	
		let o = FrontDesk.occupant.(e.pre) [e.room] |
			some o => e.guest in o
}
check NoBadEntry for 3 but 2 Room, 2 Guest, 5 Time, 4 Event

fact NoIntervening {
	all c: CheckIn {
		c.post = last[]
		or some e: Entry {
			e.pre = c.post
			e.room = c.room
			e.guest = c.guest
		}
	}
}

check NoBadEntry for 5 but 3 Room, 3 Guest, 9 Time, 8 Event




