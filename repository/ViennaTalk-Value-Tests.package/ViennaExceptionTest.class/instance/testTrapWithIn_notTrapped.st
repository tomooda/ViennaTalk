tests
testTrapWithIn_notTrapped
	self
		should: [ ViennaException
				trap: [ :v | 
					v
						ifNil: [ nil ]
						ifNotNil: [ Dictionary new
								at: 'p' put: 1;
								yourself ] ]
				with: [ :binds | 
					| p |
					p := binds at: 'p'.
					p + 2 ]
				in: [ ViennaException expression: nil ] ]
		raise: ViennaException