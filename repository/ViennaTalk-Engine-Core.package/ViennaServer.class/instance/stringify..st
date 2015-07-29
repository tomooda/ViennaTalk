private
stringify: aJsonObject
	^ String
		streamContents: [ :stream | 
			(NeoJSONWriter on: stream)
				asciiOnly: true;
				nextPut: aJsonObject ]