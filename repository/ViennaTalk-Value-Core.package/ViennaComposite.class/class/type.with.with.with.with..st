instance creation
type: aString with: anObject1 with: anObject2 with: anObject3 with: anObject4
	^ self
		type: aString
		withAll:
			(Array
				with: anObject1
				with: anObject2
				with: anObject3
				with: anObject4)