tests
testIsEnumerable
	self deny: composite isEnumerable.
	self
		assert:
			(ViennaCompositeType
				constructorName: 'T'
				withAll:
					(#(#('<ONE>') #('<TWO>' '<THREE>') #('<FOUR>' '<FIVE>' '<SIX>'))
						collect: [ :array | 
							{nil.
							false.
							(ViennaType union: (array collect: [ :string | ViennaType quote: string ]))} ])) isEnumerable