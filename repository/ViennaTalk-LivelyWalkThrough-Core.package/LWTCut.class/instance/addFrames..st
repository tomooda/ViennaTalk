adding
addFrames: aCollectionOfLWTFrame 
	frames := (frames asSet addAll: aCollectionOfLWTFrame;
				
				asSortedCollection: [:less :more | less timestamp <= more timestamp]) asArray.
	^ aCollectionOfLWTFrame