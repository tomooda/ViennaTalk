code generation-expressions
typeJudgement: aViennaNode env: aDictionary
	| expr type |
	expr := self generate: aViennaNode first env: aDictionary.
	type := self generate: aViennaNode second env: aDictionary.
	^ '(' , type , ' includes: ' , expr , ')'