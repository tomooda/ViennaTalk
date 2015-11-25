tests-matching-map
testMatchMapEnumeration6
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
						at: 1 put: 2;
						at: 2 put: 3;
						at: 4 put: 5;
						yourself))
		equals: {}