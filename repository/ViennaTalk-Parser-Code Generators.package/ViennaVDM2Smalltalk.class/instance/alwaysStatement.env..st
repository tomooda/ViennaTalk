code generation-statements
alwaysStatement: aViennaNode env: aDictionary
	| s1 s2 |
	s1 := self generate: aViennaNode first env: aDictionary.
	s2 := self generate: aViennaNode second env: aDictionary.
	^ '[' , s2 , '] ensure: [' , s1 , ']'