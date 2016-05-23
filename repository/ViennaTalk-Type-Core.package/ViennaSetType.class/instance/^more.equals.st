comparing
>= aViennaType
	^ super >= aViennaType
		or: [ (aViennaType class = self class or: [ aViennaType class = ViennaSet1Type ]) and: [ basetype >= aViennaType basetype ] ]