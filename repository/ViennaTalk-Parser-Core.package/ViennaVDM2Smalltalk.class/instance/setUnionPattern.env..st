code generation-patterns
setUnionPattern: aViennaNode env: aDictionary
	| pat1 pat2 |
	pat1 := self generate: aViennaNode first env: aDictionary.
	pat2 := self generate: aViennaNode second env: aDictionary.
	^ '(ViennaRuntimeUtil match: ' , pat1 , ' union: ' , pat2 , ')'