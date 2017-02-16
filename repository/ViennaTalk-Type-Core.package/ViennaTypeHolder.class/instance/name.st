accessing
name
	^ type ifNil: [ '[]' ] ifNotNil: [ type name ]