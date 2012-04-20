module language/intersection

abstract sig Color {}
one sig Red, Yellow, Green extends Color {}

fun colorSequence[]: Color -> Color {
	Red -> Green + Green -> Yellow + Yellow -> Red + (Color <: iden)
}

sig Light {}
sig LightState {
	color: Light -> one Color
}

sig Intersection {
	lights: set Light
}

// helper function gives the set of lights that are red
// in the given state
fun redLights[s: LightState]: set Light {
	s.color.Red
}

// At most 1 light may be non-red
pred mostlyRed[s: LightState, i: Intersection] {
	lone i.lights - redLights[s]
}

// Describes how the state of the lights in an intersection
// can evolve over time.
pred transition[s, s': LightState, i: Intersection] {
	// Only one light can change color at a time
	lone x: i.lights | s.color[x] != s'.color[x]	

	all x: i.lights | 
		let step = s.color[x] -> s'.color[x] {
	
			//Only valid color changes are allowed
			step in colorSequence[]

			// If the step is from red to non-red, then all the lights must
			// been red before. (That is stop the traffic,
			// before letting anyone go.)
			step in  (Red -> (Color - Red)) implies i.lights in redLights[s]
	}
}

pred show[s, s': LightState] {
	one Intersection
	s != s'
	one i: Intersection {

		// no extra lights
		all l: Light | l in i.lights
		mostlyRed[s, i]
		transition[s, s', i]
	}
}

run show for 4 but exactly 2 Light

assert Safe {
	all s, s': LightState, i: Intersection |
		mostlyRed[s, i] and transition[s, s', i] => mostlyRed[s', i]
}
check Safe for 4
