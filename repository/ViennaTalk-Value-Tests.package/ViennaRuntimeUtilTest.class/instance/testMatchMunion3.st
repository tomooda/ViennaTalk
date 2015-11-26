tests-matching-map
testMatchMunion3
	self
		assert:
			((ViennaRuntimeUtil
				match:
					(ViennaRuntimeUtil
						matchMapEnumeration:
							{{(ViennaRuntimeUtil matchIdentifier: 'key').
							(ViennaRuntimeUtil matchValue: 1)}})
				munion: (ViennaRuntimeUtil matchIdentifier: 'rest'))
				value:
					(Dictionary new
						at: 1 put: 2;
						at: 2 put: 3;
						yourself))
		equals: {}