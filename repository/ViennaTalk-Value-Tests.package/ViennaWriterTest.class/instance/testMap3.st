tests
testMap3
	self
		assert:
			(ViennaReader new
				parse:
					(writer
						stringify:
							{(1 -> 2).
							(3 -> 4)} asDictionary))
		equals: {1 -> 2. 3 -> 4} asDictionary 