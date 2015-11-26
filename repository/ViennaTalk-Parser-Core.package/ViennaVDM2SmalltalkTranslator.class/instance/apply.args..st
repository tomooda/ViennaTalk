parsers-expressions-operators
apply: func args: args
	^ '(' , func , ' applyTo: {' , (' . ' join: args) , '})'