private
fileSave: title do: aBlock
	(UIManager default fileSave: title extensions: #('vdm' 'vdmsl') path: self directory)
		ifNotNil: [ :reference | 
			directory := reference parent.
			reference
				writeStreamDo: [ :stream | 
					stream
						nextPutAll:
							((String new: 1024 streamContents: [ :stringStream | aBlock value: stringStream ])
								copyReplaceAll: String cr
								with: String lf) ] ]