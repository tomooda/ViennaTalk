tests-matching-tuple
testMatchTuple3
	self
		assert:
			((ViennaUtil
				matchTuple:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchValue: 2)}) value: #(1 2))
		equals: {(Dictionary new)}