Extension { #name : 'Text' }

{ #category : '*ViennaTalk-Transpiler-Core' }
Text >> ++ aTextOrString [

	^ self , aTextOrString
]

{ #category : '*ViennaTalk-Transpiler-Core' }
Text >> asViennaTracingString [

	^ string asViennaTracingString
]

{ #category : '*ViennaTalk-Transpiler-Core' }
Text >> lines [
	"Answer an array of lines composing this receiver without the line ending delimiters"

	| stream |
	stream := self readStream.
	^ Array streamContents: [ :lines |
		  [ stream atEnd ] whileFalse: [
			  lines nextPut: (stream upTo: Character cr) ] ]
]

{ #category : '*ViennaTalk-Transpiler-Core' }
Text >> string: aString [

	string := aString
]
