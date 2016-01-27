enumerating
onlyOneSatisfy: aBlock
	"Evaluate aBlock with the elements of the receiver.
	If aBlock returns true for the only one element return true.
	Otherwise return false."

	| found |
	found := false.
	self
		do: [ :each | 
			(aBlock value: each)
				ifTrue: [ 
					found
						ifTrue: [ ^ false ].
					found := true ] ].
	^ found