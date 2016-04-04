instance creation
label: aString start: anInteger1 end: anInteger2 with: aViennaNode1 with: aViennaNode2 with: aViennaNode3
	^ (self new: 3)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		at: 3 put: aViennaNode3;
		start: anInteger1 end: anInteger2;
		yourself