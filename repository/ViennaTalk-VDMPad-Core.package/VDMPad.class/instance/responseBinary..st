private
responseBinary: aByteArray
	^ ZnResponse ok: (ZnByteArrayEntity with: aByteArray type: ZnMimeType applicationOctetStream)