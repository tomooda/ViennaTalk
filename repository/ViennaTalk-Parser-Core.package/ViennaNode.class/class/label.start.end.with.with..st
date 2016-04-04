instance creation
label: aString start: anInteger1 end: anInteger2 with: aViennaNode1 with: aViennaNode2
	^ (self new: 2)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		start: anInteger1 end: anInteger2;
		yourself