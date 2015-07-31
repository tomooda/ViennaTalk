private
responseBinary: aByteArray mimeType: aZnMimeType
	^ ZnResponse ok: (ZnByteArrayEntity with: aByteArray type: aZnMimeType)