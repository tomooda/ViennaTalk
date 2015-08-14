dependents
removeDependent: anObject
	self myDependents: ((self dependents reject: [ :each | each == anObject ]) ifNotEmpty: #yourself).
	^ anObject