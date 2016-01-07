translating
vdmToJsonString: vdmString
	| vdmObj |
	vdmString trim = '()'
		ifTrue: [ ^ String new ].
	vdmObj := vdmDecoder parse: vdmString.
	vdmObj isPetitFailure
		ifTrue: [ ^ vdmObj ].
	^ NeoJSONWriter toString: (self vdmToJson: vdmObj)