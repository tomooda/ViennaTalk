code generation-expressions
iotaExpression: aViennaNode env: aDictionary
	| bind boundVars pat setOrType expr var |
	bind := self generate: aViennaNode first env: aDictionary.
	boundVars := (self boundVariables: aViennaNode first) asArray.
	pat := bind first.
	setOrType := bind second.
	expr := self generate: aViennaNode second env: aDictionary.
	var := (self varNameGenerator: 'iota' uniqueIn: (Array with: expr)) value.
	^ '(' , setOrType , ' detect: [ :' , var , '||' , (' ' join: boundVars) , '|'
		, (self binder: pat with: var vars: boundVars) , ' ifFalse: [ViennaNoMatch signal].' , expr
		, '] ifNone: [ViennaNoMatch signal])'