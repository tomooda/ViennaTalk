parsers-statements
callStatement
	^ super callStatement
		==> [ :pair | 
			| callee args |
			callee := pair first.
			args := pair second.
			callee , ' valueWithArguments: {' , (' . ' join: args) , '}' ]