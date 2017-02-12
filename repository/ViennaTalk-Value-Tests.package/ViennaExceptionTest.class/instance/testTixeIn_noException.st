tests
testTixeIn_noException
	self
		assert: (ViennaException tixe: {([ :v | {{} asDictionary} ] -> [ :binds | 2 ])} in: [ 1 ])
		equals: 1