operations
removeImageAt: key
	(UIManager default proceed: 'OK to remove mapping from ' , key , '?')
		ifTrue: [ 
			map removeKey: key ifAbsent: [  ].
			self updateImage ]