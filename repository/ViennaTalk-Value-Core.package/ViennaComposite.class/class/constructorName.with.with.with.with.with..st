instance creation
constructorName: aString with: anObject1 with: anObject2 with: anObject3 with: anObject4 with: anObject5
	^ self
		constructorName: aString
		withAll:
			(Array
				with: anObject1
				with: anObject2
				with: anObject3
				with: anObject4
				with: anObject5)