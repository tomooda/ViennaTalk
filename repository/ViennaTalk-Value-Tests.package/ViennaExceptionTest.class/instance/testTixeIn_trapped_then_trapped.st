tests
testTixeIn_trapped_then_trapped
	self
		assert:
			(ViennaException
				tixe:
					{([ :v | nil ] -> [ :binds | nil ]).
					([ :v | 
					v isInteger
						ifTrue: [ Dictionary new ]
						ifFalse: [ nil ] ]
						-> [ :binds | ViennaException expression: 'fatal' ]).
					([ :v | 
					v isString
						ifTrue: [ {('p' -> (v , ' handled'))} asDictionary ]
						ifFalse: [ nil ] ]
						-> [ :binds | 
							| p |
							p := binds at: 'p'.
							p , ' and recovered' ])}
				in: [ ViennaException expression: 1 ])
		equals: 'fatal handled and recovered'