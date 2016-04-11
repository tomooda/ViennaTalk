utilities
mapPatternSize: aViennaNode
	aViennaNode label = 'MapEnumerationPattern'
		ifTrue: [ ^ aViennaNode size ].
	aViennaNode label = 'MapMunionPattern'
		ifTrue: [ 
			| left right |
			left := self mapPatternSize: aViennaNode first.
			right := self mapPatternSize: aViennaNode second.
			left ifNotNil: [ right ifNotNil: [ ^ left + right ] ].
			^ nil ].
	^ nil