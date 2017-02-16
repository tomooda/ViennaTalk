tests
testDo
	self should: [ natBool do: [ :i |  ] ] raise: ShouldNotImplement.
	self
		assert: (Array new: 1 streamContents: [ :stream | quoteBool do: [ :v | stream nextPut: v ] ]) asSet
		equals: #(#QUOTE true false) asSet