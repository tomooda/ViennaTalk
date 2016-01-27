code generation-expressions
mapRangeRestrictedTo: aViennaNode env: aDictionary
	| map set |
	map := self generate: aViennaNode first env: aDictionary.
	set := self generate: aViennaNode second env: aDictionary.
	^ '([:map :set | map copy keysAndValuesRemove: [:k :v | (set includes: v) not]; yourself] value: ' , map , ' value: '
		, set , ')'