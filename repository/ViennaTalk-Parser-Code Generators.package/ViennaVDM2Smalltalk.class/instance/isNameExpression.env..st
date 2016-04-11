code generation-expressions
isNameExpression: aViennaNode env: aDictionary
	| name expression |
	name := self generate: aViennaNode first env: aDictionary.
	expression := self generate: aViennaNode second env: aDictionary.
	^ '(' , name , ' includes: ' , expression , ')'