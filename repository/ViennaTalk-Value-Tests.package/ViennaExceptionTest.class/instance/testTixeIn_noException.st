tests
testTixeIn_noException
	self
		assert: (ViennaException tixe: {([ :v | true ] -> [ :binds | 2 ])} in: [ 1 ])
		equals: 1