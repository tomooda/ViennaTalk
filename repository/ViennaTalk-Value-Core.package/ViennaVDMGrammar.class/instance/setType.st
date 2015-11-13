parsers-types
setType
	^ ((self reserved: 'set') , (self reserved: 'of') , type3) ==> #third