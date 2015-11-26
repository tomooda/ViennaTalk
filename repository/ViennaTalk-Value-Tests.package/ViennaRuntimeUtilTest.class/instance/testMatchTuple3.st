tests-matching-tuple
testMatchTuple3
	self
		assert:
			((ViennaRuntimeUtil
				matchTuple:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchValue: 2)}) value: #(1 2))
		equals: {(Dictionary new)}