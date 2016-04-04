instance creation
label: aString start: anInteger1 end: anInteger2 with: aViennaNode
	^ (self new: 1)
		setLabel: aString;
		at: 1 put: aViennaNode;
		start: anInteger1 end: anInteger2;
		yourself