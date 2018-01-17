module list menu
saveModule: aString
	((self modulePositionsFrom: animation specification)
		detect: [ :assoc | assoc key = aString ]
		ifNone: [  ])
		ifNotNil: [ :assoc | 
			self basePath / (aString , '.vdmsl')
				writeStreamDo: [ :stream | 
					stream
						truncate;
						nextPutAll:
							((animation specification copyFrom: assoc value first to: assoc value last)
								replaceAll: Character cr
								with: Character lf);
						close ] ]