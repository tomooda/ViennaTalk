comparing
>= aViennaType
	^ super >= aViennaType
		or: [ (aViennaType class = self class or: [ aViennaType class = ViennaSeq1Type ]) and: [ basetype >= aViennaType basetype ] ]