removing
removeFrames: aCollectionOfLWTFrame 
	frames := frames copyWithoutAll: aCollectionOfLWTFrame.
	^ aCollectionOfLWTFrame