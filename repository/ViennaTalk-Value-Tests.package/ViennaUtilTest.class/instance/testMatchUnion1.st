tests-matching-set
testMatchUnion1
	self
		assert:
			((ViennaUtil
				match:
					(ViennaUtil
						matchSetEnumeration:
							{(ViennaUtil matchIdentifier: 'member1').
							(ViennaUtil matchValue: 3)})
				union:
					(ViennaUtil
						matchSetEnumeration:
							{(ViennaUtil matchIdentifier: 'member2').
							(ViennaUtil matchValue: 4)})) value: #(1 2 3 4) asSet) asSet
		equals:
			{(Dictionary new
				at: 'member1' put: 1;
				at: 'member2' put: 2;
				yourself).
			(Dictionary new
				at: 'member1' put: 2;
				at: 'member2' put: 1;
				yourself)} asSet