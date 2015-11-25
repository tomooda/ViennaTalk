tests-matching-map
testMatchMunion1
	self
		assert:
			((ViennaUtil
				match:
					(ViennaUtil
						matchMapEnumeration:
							{{(ViennaUtil matchIdentifier: 'key').
							(ViennaUtil matchValue: 2)}})
				munion: (ViennaUtil matchIdentifier: 'rest'))
				value:
					(Dictionary new
						at: 1 put: 2;
						at: 2 put: 3;
						yourself))
		equals:
			{(Dictionary new
				at: 'key' put: 1;
				at: 'rest'
					put:
						(Dictionary new
								at: 2 put: 3;
								yourself);
				yourself)}