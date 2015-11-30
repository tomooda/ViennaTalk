instance creation
consturctorName: aString with: anObject1 with: anObject2 with: anObject3 with: anObject4
	^ self
		constructorName: aString
		withAll:
			(Array
				with: anObject1
				with: anObject2
				with: anObject3
				with: anObject4)