code generation-expressions
exists1Expression: aViennaNode env: aDictionary
	| bind pat setOrType expr var boundVars |
	bind := self generate: aViennaNode first env: aDictionary.
	pat := bind first.
	setOrType := bind second.
	expr := self generate: aViennaNode second env: aDictionary.
	var := (self varNameGenerator: 'exists1' uniqueIn: (Array with: expr)) value.
	boundVars := (self boundVariables: aViennaNode first) asArray.
	^ '(' , setOrType , ' onlyOneSatisfy: [ :' , var , '||' , (' ' join: boundVars) , '|'
		, (self binder: pat with: var vars: boundVars)
		, ' ifFalse: [ViennaNoMatch signal].' , expr , '])'