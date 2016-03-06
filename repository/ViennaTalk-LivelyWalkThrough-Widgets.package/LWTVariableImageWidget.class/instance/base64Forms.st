private
base64Forms
	| base64Forms |
	base64Forms := Dictionary new.
	forms
		keysAndValuesDo: [ :key :image | 
			base64Forms
				at: key
				put:
					(Base64MimeConverter
						mimeEncode:
							(ByteArray new: 1024 streamContents: [ :stream | PNGReadWriter putForm: image onStream: stream ]) readStream
						multiLine: false) contents ].
	^ base64Forms