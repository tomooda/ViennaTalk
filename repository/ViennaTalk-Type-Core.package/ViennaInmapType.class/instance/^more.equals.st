comparing
>= aViennaType
	^ super >= aViennaType
		or: [ aViennaType class = self class and: [ keytype >= aViennaType keytype and: [ valuetype >= aViennaType valuetype ] ] ]