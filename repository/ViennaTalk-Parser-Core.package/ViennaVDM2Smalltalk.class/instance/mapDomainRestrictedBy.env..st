code generation-expressions
mapDomainRestrictedBy: aViennaNode env: aDictionary
	| set map |
	set := self generate: aViennaNode first env: aDictionary.
	map := self generate: aViennaNode second env: aDictionary.
	^ '([:set :map | map copy keysAndValuesRemove: [:k :v | set includes: k]; yourself] value: ' , set , ' value: ' , map
		, ')'