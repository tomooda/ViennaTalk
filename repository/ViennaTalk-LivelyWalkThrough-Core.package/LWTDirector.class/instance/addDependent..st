dependents
addDependent: anObject
	(self dependents includes: anObject)
		ifFalse: [ self myDependents: (self dependents copyWithDependent: anObject) ].
	^ anObject