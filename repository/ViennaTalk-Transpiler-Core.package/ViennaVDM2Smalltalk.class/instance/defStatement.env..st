code generation-statements
defStatement: aViennaNode env: aDictionary
	| defs statement vars |
	defs := self generate: aViennaNode first env: aDictionary.
	statement := self generate: aViennaNode second env: aDictionary.
	vars := (self boundVariables: aViennaNode first) asArray.
	^ '[|' , (' ' join: vars) , '|' , ('.' join: defs) , ' ifFalse: [ViennaNoMatch signal].' , statement , '] value'