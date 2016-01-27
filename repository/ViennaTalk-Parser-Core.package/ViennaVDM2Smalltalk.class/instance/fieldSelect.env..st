code generation-expressions
fieldSelect: aViennaNode env: aDictionary
	| record field |
	record := self generate: aViennaNode first env: aDictionary.
	field := self generate: aViennaNode second env: aDictionary.
	^ '(' , record , ' at: ''' , field , ''')'