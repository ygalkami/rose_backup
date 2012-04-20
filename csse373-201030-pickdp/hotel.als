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
	key in guest.keys.pre
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

pred showEntry[t, t': Time] {
	t' = next[t]
	one e: Entry | e.pre = t and e.post = t'
}
run showEntry for 2 but exactly 2 Time, 1 Event




















