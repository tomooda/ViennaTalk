tests-matching-map
testMatchMunion2
	self
		assert:
			((ViennaRuntimeUtil match: (ViennaRuntimeUtil matchIdentifier: 'map1') munion: (ViennaRuntimeUtil matchIdentifier: 'map2'))
				value:
					(Dictionary new
						at: 1 put: 2;
						at: 2 put: 3;
						yourself)) asSet
		equals:
			{Dictionary new
				at: 'map1'
					put:
						(Dictionary new);
				at: 'map2'
					put:
						(Dictionary new
								at: 1 put: 2;
								at: 2 put: 3;
								yourself);
				yourself.
				(Dictionary new
				at: 'map1'
					put:
						(Dictionary new
								at: 1 put: 2;
								yourself);
				at: 'map2'
					put:
						(Dictionary new
								at: 2 put: 3;
								yourself);
				yourself).
			(Dictionary new
				at: 'map1'
					put:
						(Dictionary new
								at: 2 put: 3;
								yourself);
				at: 'map2'
					put:
						(Dictionary new
								at: 1 put: 2;
								yourself);
				yourself).
				Dictionary new
				at: 'map1'
					put:
						(Dictionary new
								at: 1 put: 2;
								at: 2 put: 3;
								yourself);
				at: 'map2'
					put:
						(Dictionary new);
				yourself} asSet