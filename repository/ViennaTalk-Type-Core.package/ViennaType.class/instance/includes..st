testing
includes: anObject
	^ runtimeSet ifNotNil: [ runtimeSet includes: anObject ] ifNil: [ self basicIncludes: anObject ]