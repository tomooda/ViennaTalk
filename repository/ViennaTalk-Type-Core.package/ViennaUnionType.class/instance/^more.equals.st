comparing
>= aViennaType
	^ super >= aViennaType
		or: [ 
			aViennaType class = self class
				ifTrue: [ aViennaType basetypes allSatisfy: [ :t | self >= t ] ]
				ifFalse: [ basetypes anySatisfy: [ :t | t >= aViennaType ] ] ]