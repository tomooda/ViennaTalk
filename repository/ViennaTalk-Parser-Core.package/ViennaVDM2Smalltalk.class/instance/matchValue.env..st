code generation-patterns
matchValue: aViennaNode env: aDictionary
	| literal |
	literal := self generate: aViennaNode first env: aDictionary.
	^ {#().
	('(ViennaRuntimeUtil matchValue: ' , literal , ')')}