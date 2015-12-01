instance creation
with: aViennaType with: aBlock
	^ self new
		setBasetype: aViennaType invariant: aBlock;
		yourself