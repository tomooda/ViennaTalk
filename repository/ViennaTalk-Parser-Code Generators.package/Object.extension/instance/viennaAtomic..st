*ViennaTalk-Parser-Code Generators
viennaAtomic: aBlock
	aBlock
		on: ViennaStateInvariantViolation
		do: [ :ex | ex resume ].
	self inv