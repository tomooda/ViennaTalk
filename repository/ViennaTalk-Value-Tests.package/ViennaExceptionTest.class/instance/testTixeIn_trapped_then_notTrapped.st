tests
testTixeIn_trapped_then_notTrapped
	self
		should: [ ViennaException
				tixe:
					{([ :v | nil ] -> [ :binds | nil ]).
					([ :v | 
					v isInteger
						ifTrue: [ Dictionary new ]
						ifFalse: [ nil ] ] -> [ :binds | ViennaException expression: 'fatal' ])}
				in: [ ViennaException expression: 1 ] ]
		raise: ViennaException