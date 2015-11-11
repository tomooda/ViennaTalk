parsers-types
compositeType
	| fieldList |
	fieldList := (identifiedField / equalityAbstractionField / anonymousField) star.
	^ ('compose' asParser trim , identifier , 'of' asParser trim , fieldList , 'end' asParser trim)
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]