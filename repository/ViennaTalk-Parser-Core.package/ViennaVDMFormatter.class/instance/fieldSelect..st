formatting-expressions
fieldSelect: aViennaNode
	| record field |
	record := self format: aViennaNode first.
	field := self format: aViennaNode second.
	^ record , '.' , field