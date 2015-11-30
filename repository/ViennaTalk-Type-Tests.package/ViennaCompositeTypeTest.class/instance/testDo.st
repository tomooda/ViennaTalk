tests
testDo
	self should: [ composite do: [ :v |  ] ] raise: ShouldNotImplement.
	self
		assert:
			(Array
				new: 6
				streamContents: [ :stream | 
					(ViennaCompositeType
						constructorName: 'T'
						withAll:
							(#(#('<ONE>') #('<TWO>' '<THREE>') #('<FOUR>' '<FIVE>' '<SIX>'))
								collect: [ :array | 
									{nil.
									false.
									(ViennaType union: (array collect: [ :string | ViennaType quote: string ]))} ]))
						do: [ :record | stream nextPut: ((1 to: 3) collect: [ :i | record at: i ]) ] ]) asSet
		equals:
			#(#(#'<ONE>' #'<TWO>' #'<FOUR>') #(#'<ONE>' #'<TWO>' #'<FIVE>') #(#'<ONE>' #'<TWO>' #'<SIX>') #(#'<ONE>' #'<THREE>' #'<FOUR>') #(#'<ONE>' #'<THREE>' #'<FIVE>') #(#'<ONE>' #'<THREE>' #'<SIX>'))
				asSet