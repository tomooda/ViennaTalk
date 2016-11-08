operations
loadStream: aStream
	
					[ self fromJsonObject: (NeoJSONReader on: aStream) next ]
						on: Error
						do: [ :ex | UIManager alert: 'Can not load ' , filepath pathString ] 