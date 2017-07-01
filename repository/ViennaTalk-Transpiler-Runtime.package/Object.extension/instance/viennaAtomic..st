*ViennaTalk-Transpiler-Runtime
viennaAtomic: aBlock
	aBlock
		on: ViennaStateInvariantViolation
		do: [ :ex | ex resume ].
	self inv