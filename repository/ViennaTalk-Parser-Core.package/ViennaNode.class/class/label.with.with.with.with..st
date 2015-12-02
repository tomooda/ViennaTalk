instance creation
label: aString with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 with: aViennaNode4
	^ (self new: 4)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		at: 3 put: aViennaNode3;
		at: 4 put: aViennaNode4;
		yourself