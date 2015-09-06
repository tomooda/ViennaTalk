operations
save
	(filepath notNil and: [ filepath isFile and: [ UIManager default proceed: 'OK to overwrite ' , filepath pathString ] ])
		ifTrue: [ filepath writeStreamDo: [ :stream | (NeoJSONWriter on: stream) nextPut: self asJsonObject ] ]
		ifFalse: [ self saveAs ]