private
contentTypeFor: url
	(url endsWith: '.aiff')
		ifTrue: [ ^ ZnMimeType fromString: 'audio/aiff' ].
	(url endsWith: '.js')
		ifTrue: [ ^ ZnMimeType applicationJavascript ].
	(url endsWith: '.css')
		ifTrue: [ ^ ZnMimeType textCss ].
	(url endsWith: '.png')
		ifTrue: [ ^ ZnMimeType imagePng ].
	^ 'text/html'