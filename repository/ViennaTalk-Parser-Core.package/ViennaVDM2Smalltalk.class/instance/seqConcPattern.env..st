code generation-patterns
seqConcPattern: aViennaNode env: aDictionary
	| varsAndPat1 varsAndPat2 vars pat1 pat2 |
	varsAndPat1 := self generate: aViennaNode first env: aDictionary.
	varsAndPat2 := self generate: aViennaNode second env: aDictionary.
	vars := (varsAndPat1 first , varsAndPat2 first) asSet asArray.
	pat1 := varsAndPat1 second.
	pat2 := varsAndPat2 second.
	^ {(vars reject: #isNil).
	('(ViennaRuntimeUtil match: ' , pat1 , ' conc: ' , pat2 , ')')}