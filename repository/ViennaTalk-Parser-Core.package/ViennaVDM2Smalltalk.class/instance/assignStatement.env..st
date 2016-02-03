code generation-statements
assignStatement: aViennaNode env: aDictionary
	| desig expr |
	desig := self generate: aViennaNode first env: aDictionary.
	expr := self generate: aViennaNode second env: aDictionary.
	^ desig isString
		ifTrue: [ desig , ' := ' , expr ]
		ifFalse: [ 
			| ident path |
			ident := desig first.
			path := desig second.
			ident , ' := ' , ident , ' copyAtPath: {' , (' . ' join: path) , '} put: ' , expr ]