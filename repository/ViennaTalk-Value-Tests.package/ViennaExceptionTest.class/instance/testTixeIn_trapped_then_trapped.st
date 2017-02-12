tests
testTixeIn_trapped_then_trapped
	self
		assert:
			(ViennaException
				tixe:
					{([ :v | {} ] -> [ :binds | nil ]).
					([ :v | 
					v isInteger
						ifTrue: [ {Dictionary new} ]
						ifFalse: [ {} ] ] -> [ :binds | ViennaException expression: 'fatal' ]).
					([ :v | 
					v isString
						ifTrue: [ {{('p' -> (v , ' handled'))} asDictionary} ]
						ifFalse: [ {} ] ]
						-> [ :binds | 
							| p |
							p := binds at: 'p'.
							p , ' and recovered' ])}
				in: [ ViennaException expression: 1 ])
		equals: 'fatal handled and recovered'