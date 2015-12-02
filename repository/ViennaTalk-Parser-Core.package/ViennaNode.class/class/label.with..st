instance creation
label: aString with: aViennaNode
	^ (self new: 1)
		setLabel: aString;
		at: 1 put: aViennaNode;
		yourself