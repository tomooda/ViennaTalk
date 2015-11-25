tests-matching-map
testMatchMapEnumeration5
	self
		assert:
			((ViennaUtil
				matchMapEnumeration:
					{{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2)}.
					{(ViennaUtil matchValue: 2).
					(ViennaUtil matchValue: 3)}})
				value:
					(Dictionary new
						at: 1 put: 1;
						at: 2 put: 3;
						yourself))
		equals: {}