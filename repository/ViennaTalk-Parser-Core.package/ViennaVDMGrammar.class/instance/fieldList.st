parsers-types
fieldList
	^ ((('end' asParser , followingLetter not) not and , self field) ==> #second) star