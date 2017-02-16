accessing
shortName
	^ type ifNil: [ '[]' ] ifNotNil: [ type shortName ]