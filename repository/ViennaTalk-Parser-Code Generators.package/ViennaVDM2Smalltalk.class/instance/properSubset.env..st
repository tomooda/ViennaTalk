code generation-expressions
properSubset: aViennaNode env: aDictionary
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '([:set1 :set2 | set1 size < set2 size and: [ set2 includesAll: set1 ]] value: ' , arg1 , ' value: ' , arg2 , ')'