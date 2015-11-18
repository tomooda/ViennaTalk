parsers-types
seqType
	^ ((self reserved: 'seq') , (self reserved: 'of') , type3) ==> #third