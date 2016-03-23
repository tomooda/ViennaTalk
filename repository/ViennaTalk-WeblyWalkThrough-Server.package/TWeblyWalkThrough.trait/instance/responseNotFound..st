responses
responseNotFound: aString
	| response |
	response := ZnResponse notFound: aString.
	response headers
		at: 'Access-Control-Allow-Origin' put: '*';
		at: 'Access-Control-Allow-Headers' put: 'Content-Type';
		at: 'Access-Control-Allow-Content-Type' put: ZnMimeType applicationJson printString.
	^ response