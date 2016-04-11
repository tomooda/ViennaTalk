private
formatEnumerate: anArrayOfString separator: aString ifEmpty: aBlock
	| lines |
	anArrayOfString size = 0
		ifTrue: [ ^ aBlock value ].
	lines := Array
		new: anArrayOfString size
		streamContents: [ :stream | 
			| line |
			line := anArrayOfString first.
			(self needsIndent: line)
				ifTrue: [ 
					stream nextPut: line.
					line := '' ].
			2 to: anArrayOfString size do: [ :index | 
				| element |
				element := anArrayOfString at: index.
				(self needsIndent: element)
					ifTrue: [ 
						line ifNotEmpty: [ stream nextPut: line ].
						stream nextPut: element.
						line := '' ]
					ifFalse: [ 
						| origLine |
						origLine := line.
						line := line , (line ifNotEmpty: [ aString , String space ]) , element.
						(self needsIndent: line)
							ifTrue: [ 
								origLine
									ifEmpty: [ 
										stream nextPut: line.
										line := '' ]
									ifNotEmpty: [ 
										stream nextPut: origLine.
										line := element ] ] ] ].
			line ifNotEmpty: [ stream nextPut: line ] ].
	^ aString , String cr join: lines