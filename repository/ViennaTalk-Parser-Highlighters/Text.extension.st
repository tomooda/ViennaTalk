Extension { #name : #Text }

{ #category : #'*ViennaTalk-Parser-Highlighters' }
Text >> ++ aTextOrString [

	^ self , aTextOrString
]

{ #category : #'*ViennaTalk-Parser-Highlighters' }
Text >> lines [
	"Answer an array of lines composing this receiver without the line ending delimiters"

	| stream |
	stream := self readStream.
	^ Array streamContents: [ :lines |
		  [ stream atEnd ] whileFalse: [
			  lines nextPut: (stream upTo: Character cr) ] ]
]

{ #category : #'*ViennaTalk-Parser-Highlighters' }
Text >> string: aString [

	string := aString
]
