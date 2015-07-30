private
responseHtml: aString
	^ ZnResponse ok: (ZnStringEntity html: aString)