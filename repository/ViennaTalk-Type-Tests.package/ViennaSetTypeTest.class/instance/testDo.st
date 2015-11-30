tests
testDo
	self should: [ setofnat do: [ :i |  ] ] raise: ShouldNotImplement.
	self
		assert: (Array new: 1 streamContents: [ :stream | setofbool do: [ :v | stream nextPut: v ] ]) asSet
		equals:
			{({} asSet).
			({true} asSet).
			({false} asSet).
			({true.
			false} asSet)} asSet