accessing
frames: aCollectionOfLWTFrame 
	frames := (aCollectionOfLWTFrame
				asSortedCollection: [:less :more | less timestamp <= more timestamp]) asArray