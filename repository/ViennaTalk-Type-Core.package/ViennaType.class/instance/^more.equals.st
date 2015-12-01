comparing
>= aViennaType
	^ self = aViennaType or: [ (aViennaType isKindOf: ViennaConstrainedType) and: [ self >= aViennaType basetype ] ]