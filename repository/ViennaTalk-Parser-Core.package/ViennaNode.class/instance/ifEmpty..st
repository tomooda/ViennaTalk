controlling
ifEmpty: aBlock
	^ self isEmpty
		ifTrue: [ aBlock cull: self ]
		ifFalse: [ self ]