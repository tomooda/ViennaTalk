comparing
= anObject
	^ self class = anObject class and: [ keytype = anObject keytype and: [ valuetype = anObject valuetype ] ]