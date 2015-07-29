converting
vdmToHtml: aString 
	^ '<div style="float: left; padding-left: 20px; font: 10pt normal sans-serif">'
		, (parser
				parse: aString
				onError: [aString asHtml]) , '</div><div style="clear: left"></div>'