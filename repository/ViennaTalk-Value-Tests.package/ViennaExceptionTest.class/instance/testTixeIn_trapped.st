tests
testTixeIn_trapped
	self
		assert:
			(ViennaException
				tixe:
					{([ :v | nil ] -> [ :binds | nil ]).
					([ :v | {('p' -> (v + 2))} asDictionary ]
						-> [ :binds | 
							| p |
							p := binds at: 'p'.
							p + 3 ])}
				in: [ ViennaException expression: 1 ])
		equals: 6