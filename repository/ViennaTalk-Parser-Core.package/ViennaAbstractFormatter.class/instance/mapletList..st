formatting-expressions
mapletList: aViennaNode
	| maplets |
	maplets := self formatAll: aViennaNode.
	^ ','
		,
			((self anyNeedsIndent: maplets)
				ifTrue: [ String cr ]
				ifFalse: [ String space ]) join: maplets