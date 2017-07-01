code generation-patterns
seqConcPattern: aViennaNode env: aDictionary
	| pat1 pat2 |
	pat1 := self generate: aViennaNode first env: aDictionary.
	pat2 := self generate: aViennaNode second env: aDictionary.
	^ '(ViennaRuntimeUtil match: ' , pat1 , ' conc: ' , pat2
		, ((self seqPatternSize: aViennaNode first) ifNotNil: [ :size | ' left: ' , size printString ] ifNil: [ '' ])
		, ((self seqPatternSize: aViennaNode second) ifNotNil: [ :size | ' right: ' , size printString ] ifNil: [ '' ]) , ')'