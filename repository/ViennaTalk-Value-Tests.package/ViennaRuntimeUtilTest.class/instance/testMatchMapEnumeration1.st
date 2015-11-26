tests-matching-map
testMatchMapEnumeration1
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
						yourself))
		equals:
			{(Dictionary new
				at: 'member' put: 1;
				yourself)}