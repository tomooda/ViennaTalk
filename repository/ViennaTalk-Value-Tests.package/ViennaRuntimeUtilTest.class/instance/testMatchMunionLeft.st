tests-matching-map
testMatchMunionLeft
	self
		assert:
			((ViennaRuntimeUtil
				match:
					(ViennaRuntimeUtil
						matchMapEnumeration:
							{{(ViennaRuntimeUtil matchIdentifier: 'key').
							(ViennaRuntimeUtil matchValue: 2)}})
				munion: (ViennaRuntimeUtil matchIdentifier: 'rest')
				left: 1)
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