parsers-types
compositeType
	| fieldList |
	fieldList := ((('end' asParser , followingLetter not) not and
		, (self identifiedField / self equalityAbstractionField / self anonymousField) trim) ==> #second) star.
	^ ((self reserved: 'compose' asParser) , identifier , (self reserved: 'of') , fieldList , (self reserved: 'end'))
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]