private
fileOpen: title extensions: anArrayOfString do: aBlock
	(UIManager default
		fileOpen: title
		extensions: anArrayOfString
		path: self directory
		preview: #text)
		ifNotNil: [ :stream | 
			directory := stream name asFileReference parent.
			aBlock value: (stream contents copyReplaceAll: String lf with: String cr) readStream ]