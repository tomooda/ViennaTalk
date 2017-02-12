tests
testTixeIn_notTrapped
	self
		should: [ ViennaException
				tixe: {([ :v | {} ] -> [ :binds | 2 ])}
				in: [ ViennaException expression: 1 ] ]
		raise: ViennaException