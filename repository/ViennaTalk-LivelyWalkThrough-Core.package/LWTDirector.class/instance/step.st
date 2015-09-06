stepping
step
	| m |
	m := self owner.
	[ 
	m isNil
		ifTrue: [ self releaseHandlers ].
	m == World
		ifTrue: [ ^ self ].
	m := m owner ] repeat