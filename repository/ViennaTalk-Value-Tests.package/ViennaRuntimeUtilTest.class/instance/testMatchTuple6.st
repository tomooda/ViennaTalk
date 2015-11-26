tests-matching-tuple
testMatchTuple6
	self
		assert:
			((ViennaRuntimeUtil
				matchTuple:
					{(ViennaRuntimeUtil matchIdentifier: 'field').
					(ViennaRuntimeUtil matchValue: 3)}) value: #(1 2))
		equals: {}