formatting-expressions
recordModifier: aViennaNode
	| record mapletList |
	record := self format: aViennaNode first.
	mapletList := self format: aViennaNode second.
	^ self mu , '(' , record , ','
		,
			((self needsIndent: record , mapletList)
				ifTrue: [ String cr , indent , (self indentString: mapletList) ]
				ifFalse: [ mapletList ]) , ')'