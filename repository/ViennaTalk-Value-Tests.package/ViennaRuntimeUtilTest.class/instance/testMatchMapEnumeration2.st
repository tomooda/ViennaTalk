tests-matching-map
testMatchMapEnumeration2
	self
		assert:
			((ViennaRuntimeUtil
				matchMapEnumeration:
					{{(ViennaRuntimeUtil matchIdentifier: 'member1').
					(ViennaRuntimeUtil matchIdentifier: 'member2')}.
					{(ViennaRuntimeUtil matchIdentifier: 'member2').
					(ViennaRuntimeUtil matchValue: 3)}})
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