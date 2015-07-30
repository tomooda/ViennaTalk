private
responseJSON: anObject
	^ ZnResponse
		ok:
			(ZnStringEntity
				with:
					(String
						streamContents: [ :stream | 
							(NeoJSONWriter on: stream)
								asciiOnly: true;
								nextPut: anObject ])
				type: ZnMimeType applicationJson)