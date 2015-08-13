compiling
compileToSmalltalk: aString ifError: errorBlock
	| sourceStream |
	sourceStream := aString readStream asPetitStream.
	^ parser parse: sourceStream onError: [ :msg :position | errorBlock cull: msg cull: position ]