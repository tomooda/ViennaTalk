formatting-expressions
sequenceEnumeration: aViennaNode
	| elements |
	elements := self formatAll: aViennaNode first.
	^ '[' , (self formatEnumerate: elements ifEmpty: [ '' ]) , ']'