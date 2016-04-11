code generation-expressions
isBasicExpression: aViennaNode env: aDictionary
	| name expression |
	name := self generate: aViennaNode first env: aDictionary.
	expression := self generate: aViennaNode second env: aDictionary.
	^ '(ViennaType ' , name , ' includes: ' , expression , ')'