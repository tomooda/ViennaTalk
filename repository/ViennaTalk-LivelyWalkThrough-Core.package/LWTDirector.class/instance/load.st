operations
load
	(LivelyWalkThrough
		fileOpen: (self urlPrefix ifEmpty: [ 'Lively Walk-Through' ])
		extensions: #('lwt')
		path: (filepath ifNil: [ FileSystem workingDirectory parent parent ])
		preview: nil)
		ifNotNil: [ :reference | 
			filepath := reference.
			filepath
				readStreamDo: [ :stream | 
					self loadStream: stream ] ]