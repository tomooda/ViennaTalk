private
responsePNG: aByteArray
	^ ZnResponse ok: (ZnByteArrayEntity with: aByteArray type: ZnMimeType imagePng)