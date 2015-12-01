comparing
= anObject
	^ self class = anObject class and: [ basetype = anObject basetype and: [ invariant = anObject invariant ] ]