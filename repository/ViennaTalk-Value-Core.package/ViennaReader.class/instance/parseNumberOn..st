parsing
parseNumberOn: aStream
	^ Number readFrom: aStream ifFail: [ self error: 'number expected' ]