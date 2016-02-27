utilities
random
	^ RandomGenerator ifNil: [ RandomGenerator := Random new ]