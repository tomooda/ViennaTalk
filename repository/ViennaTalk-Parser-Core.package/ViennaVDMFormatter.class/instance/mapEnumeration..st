formatting-expressions
mapEnumeration: aViennaNode
	| lines |
	aViennaNode size = 0
		ifTrue: [ ^ '{|->}' ].
	lines := Array
		new: aViennaNode size
		streamContents: [ :stream | 
			| line |
			line := self format: aViennaNode first.
			(self needsIndent: line)
				ifTrue: [ 
					stream nextPut: line.
					line := '' ].
			1 to: aViennaNode size do: [ :index | 
				| element |
				element := self format: (aViennaNode at: index).
				(self needsIndent: element)
					ifTrue: [ 
						line ifNotEmpty: [ stream nextPut: line ].
						stream nextPut: element.
						line := '' ]
					ifFalse: [ 
						line := line , (line ifNotEmpty: [ ', ' ]) , element.
						(self needsIndent: line)
							ifTrue: [ 
								stream nextPut: line.
								line := '' ] ] ].
			line ifNotEmpty: [ stream nextPut: line ] ].
	^ '{' , (',' , String cr join: lines) , '}'