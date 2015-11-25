tests-matching-map
testMatchMapEnumeration3
	self
		assert:
			((ViennaUtil
				matchMapEnumeration:
					{{(ViennaUtil matchIdentifier: 'member1').
					(ViennaUtil matchIdentifier: 'member2')}.
					{(ViennaUtil matchIdentifier: 'member3').
					(ViennaUtil matchIdentifier: 'member4')}})
				value:
					(Dictionary new
						at: 1 put: 2;
						at: 2 put: 3;
						yourself)) asSet
		equals:
			{(Dictionary new
				at: 'member1' put: 1;
				at: 'member2' put: 2;
				at: 'member3' put: 2;
				at: 'member4' put: 3;
				yourself).
			(Dictionary new
				at: 'member1' put: 2;
				at: 'member2' put: 3;
				at: 'member3' put: 1;
				at: 'member4' put: 2;
				yourself)} asSet