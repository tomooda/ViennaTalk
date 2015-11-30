comparing
>= aViennaType
	^ super >= aViennaType
		or: [ 
			aViennaType class = self class
				and: [ 
					argtypes size = aViennaType argtypes size
						and: [ 
							((1 to: argtypes size) allSatisfy: [ :i | (aViennaType argtypes at: i) >= (argtypes at: i) ])
								and: returntype >= aViennaType returntype ] ] ]