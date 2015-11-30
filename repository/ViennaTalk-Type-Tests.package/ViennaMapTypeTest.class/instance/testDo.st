tests
testDo
	self should: [ bool2nat do: [ :i |  ] ] raise: ShouldNotImplement.
	self
		assert: (Array new: 1 streamContents: [ :stream | bool2optbool do: [ :v | stream nextPut: v ] ]) asSet
		equals:
			{(Dictionary newFromPairs: #()).
			(Dictionary newFromPairs: #(true true)).
			(Dictionary newFromPairs: #(true false)).
			(Dictionary newFromPairs: #(true nil)).
			(Dictionary newFromPairs: #(false true)).
			(Dictionary newFromPairs: #(false false)).
			(Dictionary newFromPairs: #(false nil)).
			(Dictionary newFromPairs: #(true true false true)).
			(Dictionary newFromPairs: #(true true false false)).
			(Dictionary newFromPairs: #(true true false nil)).
			(Dictionary newFromPairs: #(true false false true)).
			(Dictionary newFromPairs: #(true false false false)).
			(Dictionary newFromPairs: #(true false false nil)).
			(Dictionary newFromPairs: #(true nil false true)).
			(Dictionary newFromPairs: #(true nil false false)).
			(Dictionary newFromPairs: #(true nil false nil))} asSet