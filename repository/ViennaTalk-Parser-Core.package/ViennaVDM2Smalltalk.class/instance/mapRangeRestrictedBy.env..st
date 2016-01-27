code generation-expressions
mapRangeRestrictedBy: aViennaNode env: aDictionary
	| map set |
	map := self generate: aViennaNode first env: aDictionary.
	set := self generate: aViennaNode second env: aDictionary.
	^ '([:map :set | map copy keysAndValuesRemove: [:k :v | set includes: v]; yourself] value: ' , map , ' value: ' , set
		, ')'