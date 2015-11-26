tests-matching-map
testMatchMapEnumeration3
	self
		assert:
			((ViennaRuntimeUtil
				matchMapEnumeration:
					{{(ViennaRuntimeUtil matchIdentifier: 'member1').
					(ViennaRuntimeUtil matchIdentifier: 'member2')}.
					{(ViennaRuntimeUtil matchIdentifier: 'member3').
					(ViennaRuntimeUtil matchIdentifier: 'member4')}})
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