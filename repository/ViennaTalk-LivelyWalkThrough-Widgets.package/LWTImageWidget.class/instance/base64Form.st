private
base64Form
	^ form
		ifNotNil: [ 
			(Base64MimeConverter
				mimeEncode:
					(ByteArray new: 1024 streamContents: [ :stream | PNGReadWriter putForm: form onStream: stream ]) readStream
				multiLine: false) contents ]