formatting-definitions
assignmentDefinition: aViennaNode
	^ aViennaNode first , ':' , (self format: aViennaNode second)
		, (aViennaNode third ifNotNil: [ ' := ' , (self format: aViennaNode third) ] ifNil: [ '' ])