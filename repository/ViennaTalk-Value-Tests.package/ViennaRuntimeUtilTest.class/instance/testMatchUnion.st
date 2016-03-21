tests-matching-set
testMatchUnion
	self
		assert:
			((ViennaRuntimeUtil
				match:
					(ViennaRuntimeUtil
						matchSetEnumeration:
							{(ViennaRuntimeUtil matchIdentifier: 'member1').
							(ViennaRuntimeUtil matchValue: 3)})
				union:
					(ViennaRuntimeUtil
						matchSetEnumeration:
							{(ViennaRuntimeUtil matchIdentifier: 'member2').
							(ViennaRuntimeUtil matchValue: 4)})) value: #(1 2 3 4) asSet) asSet
		equals:
			{(Dictionary new
				at: 'member1' put: 1;
				at: 'member2' put: 2;
				yourself).
			(Dictionary new
				at: 'member1' put: 2;
				at: 'member2' put: 1;
				yourself)} asSet