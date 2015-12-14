formatting-statements
casesStatement: aViennaNode
	^ 'cases ' , (self format: aViennaNode first) , ':' , (self newlineIndentString: (self format: aViennaNode second))
		, (aViennaNode third ifNotNil: [ ',' , (self newlineIndentString: (self format: aViennaNode third)) ] ifNil: [ '' ])
		, String cr , 'end'