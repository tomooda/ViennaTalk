workspace pane
acceptWorkspace: aStringOrText
	super acceptWorkspace: aStringOrText.
	self basePath / '.workspace'
		writeStreamDo: [ :stream | 
			stream
				truncate;
				nextPutAll: (aStringOrText asString replaceAll: Character cr with: Character lf) ]