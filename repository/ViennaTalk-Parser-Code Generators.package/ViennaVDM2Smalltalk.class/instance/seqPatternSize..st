utilities
seqPatternSize: aViennaNode
	aViennaNode label = 'SeqEnumPattern'
		ifTrue: [ ^ aViennaNode size ].
	aViennaNode label = 'SeqConcPattern'
		ifTrue: [ 
			| left right |
			left := self seqPatternSize: aViennaNode first.
			right := self seqPatternSize: aViennaNode second.
			left ifNotNil: [ right ifNotNil: [ ^ left + right ] ].
			^ nil ].
	^ nil