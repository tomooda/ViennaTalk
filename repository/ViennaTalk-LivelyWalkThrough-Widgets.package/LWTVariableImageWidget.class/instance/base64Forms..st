private
base64Forms: aDictionary
	| newForms |
	newForms := Dictionary new.
	aDictionary
		keysAndValuesDo: [ :key :base64 | 
			newForms
				at: (key ifEmpty: [ nil ])
				put: (PNGReadWriter formFromStream: (Base64MimeConverter mimeDecodeToBytes: base64 readStream)) ].
	forms := newForms