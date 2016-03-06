private
base64Form: aString
	form := PNGReadWriter formFromStream: (Base64MimeConverter mimeDecodeToBytes: aString readStream)