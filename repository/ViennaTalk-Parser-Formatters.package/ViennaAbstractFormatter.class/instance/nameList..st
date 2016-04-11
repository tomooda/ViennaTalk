formatting-interfaces
nameList: aViennaNode
	| names |
	names := self formatAll: aViennaNode.
	^ ', ' join: names