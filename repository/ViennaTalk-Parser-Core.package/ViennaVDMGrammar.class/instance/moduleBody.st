parsers-definitions
moduleBody
	^ ((self reserved: 'definitions') , self definitionBlock plus) ==> #second