tests
testDo
	self should: [ (int inv: [ :i | i < 0 ]) do: [ :i |  ] ] raise: ShouldNotImplement.
	self
		assert: (Array new: 1 streamContents: [ :stream | (bool inv: [ :b | b ]) do: [ :b | stream nextPut: b ] ])
		equals: #(true)