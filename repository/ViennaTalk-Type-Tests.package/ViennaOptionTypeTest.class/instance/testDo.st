tests
testDo
	self should: [ optionNat do: [ :i |  ] ] raise: ShouldNotImplement.
	self
		assert: (Array new: 1 streamContents: [ :stream | optionQuote do: [ :v | stream nextPut: v ] ]) asSet
		equals: #(#'<QUOTE>' nil) asSet