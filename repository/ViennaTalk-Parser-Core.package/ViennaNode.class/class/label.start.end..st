instance creation
label: aString start: anInteger1 end: anInteger2
	^ (self new: 0)
		setLabel: aString;
		start: anInteger1 end: anInteger2;
		yourself