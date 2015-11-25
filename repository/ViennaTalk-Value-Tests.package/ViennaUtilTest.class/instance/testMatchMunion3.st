tests-matching-map
testMatchMunion3
	self
		assert:
			((ViennaUtil
				match:
					(ViennaUtil
						matchMapEnumeration:
							{{(ViennaUtil matchIdentifier: 'key').
							(ViennaUtil matchValue: 1)}})
				munion: (ViennaUtil matchIdentifier: 'rest'))
				value:
					(Dictionary new
						at: 1 put: 2;
						at: 2 put: 3;
						yourself))
		equals: {}