instance creation
label: aString with: aViennaNode1 with: aViennaNode2
	^ (self new: 2)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		yourself