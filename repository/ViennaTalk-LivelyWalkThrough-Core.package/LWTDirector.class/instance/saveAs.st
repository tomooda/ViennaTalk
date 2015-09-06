operations
saveAs
	(UIManager default
		fileSave: (self urlPrefix ifEmpty: [ 'Lively Walk-Through' ])
		extensions: #('lwt')
		path: (filepath ifNil: [ FileSystem workingDirectory parent parent ]) parent)
		ifNotNil: [ :reference | 
			(reference exists not or: [ UIManager proceed: 'OK to overwrite ' , reference pathString ])
				ifTrue: [ 
					filepath := reference.
					reference
						writeStreamDo: [ :stream | 
							[ (NeoJSONWriter on: stream) nextPut: self asJsonObject ]
								on: Error
								do: [ :ex | UIManager default alert: 'Can not write on ' , reference pathString ] ] ] ]