translating
vdmToJsonString: vdmString
	| vdmObj |
	vdmString trim = '()'
		ifTrue: [ ^ String new ].
	vdmObj := vdmDecoder parse: vdmString.
	vdmObj isPetitFailure
		ifTrue: [ ^ vdmString convertToEncoding: 'utf-8' ].
	^ String streamContents: [ :stream |
			(NeoJSONWriter on: stream) asciiOnly: true; nextPut: (self vdmToJson: vdmObj) ]