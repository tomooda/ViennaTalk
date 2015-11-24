parsers-expressions-operators
apply: func args: args
	| t1 |
	t1 := '_f'.
	[ (func findString: t1) > 0 or: [ args contains: [ :arg | (arg findString: t1) > 0 ] ] ] whileTrue: [ t1 := t1 , '_' ].
	^ args ifNotEmpty: ['(' , func , ' in: [ :' , t1 , ' | ' , t1 , ' isCollection ifTrue: [ ' , t1 , ' at: ' , args first , '] ifFalse: [ '
		, t1 , ' valueWithArguments: {' , (' . ' join: args) , '}]])'] ifEmpty: [ func, ' value' ]