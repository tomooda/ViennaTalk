code generation-statements
whileLoop: aViennaNode env: aDictionary
	| cond body |
	cond := self generate: aViennaNode first env: aDictionary.
	body := self generate: aViennaNode second env: aDictionary.
	^ '[' , cond , '] whileTrue: [' , body , ']'