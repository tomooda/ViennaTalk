parsers-statements
othersStatement
	^ ((self reserved: 'others') , (self operator: '->') , statement) ==> #third