responses
responseServerError: aStrng
	| response |
	response := ZnResponse serverError: aStrng.
	response headers
		at: 'Access-Control-Allow-Origin' put: '*';
		at: 'Access-Control-Allow-Headers' put: 'Content-Type';
		at: 'Access-Control-Allow-Content-Type' put: ZnMimeType applicationJson printString.
	^ response