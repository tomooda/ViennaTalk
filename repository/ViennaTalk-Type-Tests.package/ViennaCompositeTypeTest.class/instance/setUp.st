running
setUp
	super setUp.
	composite := ViennaCompositeType
		constructorName: 'T'
		withAll:
			{{nil.
			false.
			(ViennaType int)}.
			{'f2'.
			true.
			(ViennaType nat)}.
			{'f3'.
			false.
			(ViennaType quote: 'QUOTE')}}