operations
load
	(UIManager default
		fileOpen: (self urlPrefix ifEmpty: [ 'Lively Walk-Through' ])
		extensions: #('lwt')
		path: (filepath ifNil: [ FileSystem workingDirectory parent parent ]) parent
		preview: nil)
		ifNotNil: [ :reference | 
			filepath := reference fullName asFileReference.
			reference close.
			filepath
				readStreamDo: [ :stream | 
					[ self fromJsonObject: (NeoJSONReader on: stream) next ]
						on: Error
						do: [ :ex | UIManager alert: 'Can not load ' , filepath pathString ] ] ]