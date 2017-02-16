tests
testDo
	self should: [ set1ofnat do: [ :i |  ] ] raise: ShouldNotImplement.
	self
		assert: (Array new: 1 streamContents: [ :stream | set1ofbool do: [ :v | stream nextPut: v ] ]) asSet
		equals:
			{({} asSet).
			({true} asSet).
			({false} asSet).
			({true.
			false} asSet)} asSet