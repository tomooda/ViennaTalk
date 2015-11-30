instance creation
withAll: anArrayOfViennaType with: aViennaType
	^ self new
		setArgtypes: anArrayOfViennaType returntype: aViennaType;
		yourself