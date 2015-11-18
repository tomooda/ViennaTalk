parsers-expressions-operators
map: map rangeRestrictedBy: set
	^ '([:map :set | map copy keysAndValuesRemove: [:k :v | set includes: v]; yourself] value: ' , map , ' value: ' , set
		, ')'