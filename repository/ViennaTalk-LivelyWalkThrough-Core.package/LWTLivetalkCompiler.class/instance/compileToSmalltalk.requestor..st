compiling
compileToSmalltalk: aString requestor: requestor
	| sourceStream |
	sourceStream := aString readStream asPetitStream.
	^ parser parse: sourceStream onError: [ :msg :position | requestor notify: msg at: position in: sourceStream ]