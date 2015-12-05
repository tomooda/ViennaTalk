parsers-definitions
isSubclassResponsibility
	^ ((self reserved: 'is') , (self reserved: 'subclass') , (self reserved: 'responsibility')) ==> [ :array | nil ]