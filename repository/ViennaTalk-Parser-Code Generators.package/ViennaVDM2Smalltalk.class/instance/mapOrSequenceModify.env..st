code generation-expressions
mapOrSequenceModify: aViennaNode env: aDictionary
	| arg1 arg2 varGenerator |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	varGenerator := self varNameGenerator: 'override' uniqueIn: (Array with: arg1 with: arg2).
	^ '[:mapOrSeq :map | map keysAndValuesDo: [:k :v | mapOrSeq at: k put: v]. mapOrSeq] value: ' , arg1 , ' copy value: '
		, arg2