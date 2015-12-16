parsers-expressions-operators
functionTypeInstantiation: func args: args
	^ ViennaNode label: 'FunctionTypeInstantiation' with: func with: (ViennaNode label: 'FunctionTypeArgs' withAll: args)