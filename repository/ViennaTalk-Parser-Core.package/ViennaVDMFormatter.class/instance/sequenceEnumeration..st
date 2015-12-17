formatting-expressions
sequenceEnumeration: aViennaNode
	|  lines |
	aViennaNode first size = 0
		ifTrue: [ ^ '[]' ].
		
	lines := Array
		new: aViennaNode first size
		streamContents: [ :stream | 
			| node line |
			node := aViennaNode first.
			line := self format: node first.
			(self needsIndent: line)
				ifTrue: [ 
					stream nextPut: line.
					line := '' ].
			2 to: node size do: [ :index | 
				| element |
				element := self format: (node at: index).
				(self needsIndent: element)
					ifTrue: [ 
						line ifNotEmpty: [ stream nextPut: line ].
						stream nextPut: element.
						line := '' ]
					ifFalse: [ 
						| origLine |
						origLine := line.
						line := line , (line ifNotEmpty: [ ', ' ]) , element.
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
	^ '[' , (',' , String cr join: lines) , ']'