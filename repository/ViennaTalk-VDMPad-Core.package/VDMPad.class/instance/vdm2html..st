request handling-api
vdm2html: aZnRequest
	^ self
		responseHtml:
			(aZnRequest contents
				ifNil: [ String new ]
				ifNotNil: [ :contents | contents trimmed ifEmpty: [ String new ] ifNotEmpty: [ :value | VDMValue2HtmlDiagram current vdmToHtml: value ] ])