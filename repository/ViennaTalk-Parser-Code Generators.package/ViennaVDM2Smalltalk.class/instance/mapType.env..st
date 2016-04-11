code generation-types
mapType: aViennaNode env: aDictionary
	| domaintype rangetype |
	domaintype := self generate: aViennaNode first env: aDictionary.
	rangetype := self generate: aViennaNode second env: aDictionary.
	^ '(' , domaintype , ' mapTo: ' , rangetype , ')'