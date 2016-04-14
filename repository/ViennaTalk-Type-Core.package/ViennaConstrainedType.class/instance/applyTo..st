instance creation
applyTo: anArray
	| value |
	value := basetype applyTo: anArray.
	^ (invariant value: value)
		ifTrue: [ value ]
		ifFalse: [ ViennaStateInvariantViolation signal ]