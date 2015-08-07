adding
addFrame: anLWTFrame 
	frames := (frames asSet add: anLWTFrame;
				
				asSortedCollection: [:less :more | less timestamp <= more timestamp]) asArray.
	^ anLWTFrame