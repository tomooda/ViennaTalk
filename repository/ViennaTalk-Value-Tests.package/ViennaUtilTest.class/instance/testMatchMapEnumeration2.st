tests-matching-map
testMatchMapEnumeration2
	self
		assert:
			((ViennaUtil
				matchMapEnumeration:
					{{(ViennaUtil matchIdentifier: 'member1').
					(ViennaUtil matchIdentifier: 'member2')}.
					{(ViennaUtil matchIdentifier: 'member2').
					(ViennaUtil matchValue: 3)}})
				value:
					(Dictionary new
						at: 1 put: 2;
						at: 2 put: 3;
						yourself))
		equals:
			{(Dictionary new
				at: 'member1' put: 1;
				at: 'member2' put: 2;
				yourself)}