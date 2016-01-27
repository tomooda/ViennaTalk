code generation-expressions
exists1Expression: aViennaNode env: aDictionary
	| bind pat setOrType expr var |
	bind := self generate: aViennaNode first env: aDictionary.
	pat := bind first.
	setOrType := bind second.
	expr := self generate: aViennaNode second env: aDictionary.
	var := (self varNameGenerator: 'exists1' uniqueIn: (Array with: expr)) value.
	^ '(' , setOrType , ' onlyOneSatisfy: [ :' , var , '||' , (' ' join: pat first) , '|'
		, (self binder: pat second with: var vars: pat first) , ' ifFalse: [ViennaNoMatch signal].' , expr , '])'