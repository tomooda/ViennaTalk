formatting-expressions
mapEnumeration: aViennaNode
	| elements |
	elements := self formatAll: aViennaNode.
	^ '{' , (self formatEnumerate: elements ifEmpty: [ self maplet ]) , '}'