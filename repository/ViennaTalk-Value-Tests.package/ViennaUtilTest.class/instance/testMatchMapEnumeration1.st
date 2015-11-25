tests-matching-map
testMatchMapEnumeration1
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
						yourself))
		equals:
			{(Dictionary new
				at: 'member' put: 1;
				yourself)}