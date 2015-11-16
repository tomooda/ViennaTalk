parsers-expressions-operators
apply: func args: args
	^ '(' , func , ' in: [ :_f | _f isCollection ifTrue: [ _f at: ' , args first , '] ifFalse: [ _f valueWithArguments: {'
		, (' . ' join: args) , '}]])'