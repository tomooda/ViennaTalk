operations
removeImageAt: key
	(UIManager default proceed: 'OK to remove mapping from ' , key , '?')
		ifTrue: [ 
			forms removeKey: key ifAbsent: [  ].
			self updateImage ]