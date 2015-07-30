private
responseJS: aString
	^ ZnResponse ok: (ZnStringEntity with: aString type: ZnMimeType applicationJavascript)