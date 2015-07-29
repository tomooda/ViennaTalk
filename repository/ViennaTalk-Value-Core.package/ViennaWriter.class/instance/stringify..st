stringifying
stringify: anObject
	^ String streamContents: [ :stream | self stringify: anObject into: stream ]