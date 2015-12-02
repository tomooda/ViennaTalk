parsers-expressions-operators
apply: func args: args
	^ ViennaNode label: 'Apply' with: func with: args