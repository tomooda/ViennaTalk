utilities
setPatternSize: aViennaNode
	aViennaNode label = 'SetEnumPattern'
		ifTrue: [ ^ aViennaNode size ].
	aViennaNode label = 'SetUnionPattern'
		ifTrue: [ 
			| left right |
			left := self setPatternSize: aViennaNode first.
			right := self setPatternSize: aViennaNode second.
			left ifNotNil: [ right ifNotNil: [ ^ left + right ] ].
			^ nil ].
	^ nil