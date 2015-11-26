tests-matching-map
testMatchMapEnumeration6
	self
		assert:
			((ViennaRuntimeUtil
				matchMapEnumeration:
					{{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2)}.
					{(ViennaRuntimeUtil matchValue: 2).
					(ViennaRuntimeUtil matchValue: 3)}})
				value:
					(Dictionary new
						at: 1 put: 2;
						at: 2 put: 3;
						at: 4 put: 5;
						yourself))
		equals: {}