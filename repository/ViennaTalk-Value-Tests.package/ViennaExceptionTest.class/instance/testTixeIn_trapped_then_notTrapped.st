tests
testTixeIn_trapped_then_notTrapped
	self
		should: [ ViennaException
				tixe:
					{([ :v | {} ] -> [ :binds | nil ]).
					([ :v | 
					v isInteger
						ifTrue: [ {Dictionary new} ]
						ifFalse: [ {} ] ] -> [ :binds | ViennaException expression: 'fatal' ])}
				in: [ ViennaException expression: 1 ] ]
		raise: ViennaException