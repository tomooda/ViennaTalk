controlling
ifNotEmpty: aBlock
	^ self isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]