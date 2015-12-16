formatting-statements
othersStatement: aViennaNode
	| statement |
	statement := self format: aViennaNode first.
	^ 'others ->'
		,
			((self needsIndent: statement)
				ifTrue: [ String cr , indent ]
				ifFalse: [ String space ]) , statement