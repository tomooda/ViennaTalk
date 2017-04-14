private
fileSave: title extensions: anArrayOfString do: aBlock
	(UIManager default fileSave: title extensions: anArrayOfString path: self directory)
		ifNotNil: [ :reference | 
			directory := reference parent.
			reference
				writeStreamDo: [ :stream | 
					stream
						nextPutAll:
							((String new: 1024 streamContents: [ :stringStream | aBlock value: stringStream ])
								copyReplaceAll: String cr
								with: String lf) ] ]