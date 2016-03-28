formatting-patterns and binds
bindList: aViennaNode
	| binds |
	binds := self formatAll: aViennaNode.
	^ ','
		,
			((self anyNeedsIndent: binds)
				ifTrue: [ String cr ]
				ifFalse: [ String space ]) join: binds