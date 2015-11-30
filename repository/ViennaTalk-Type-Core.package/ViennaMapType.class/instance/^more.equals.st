comparing
>= aViennaType
	^ super >= aViennaType
		or: [ 
			(aViennaType class = self class or: [ aViennaType class = ViennaInmapType ])
				and: [ keytype >= aViennaType keytype and: [ valuetype >= aViennaType valuetype ] ] ]