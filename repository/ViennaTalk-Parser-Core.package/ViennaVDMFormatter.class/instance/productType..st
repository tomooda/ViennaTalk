formatting-types
productType: aViennaNode
	| lines |
	lines := Array
		new: aViennaNode size
		streamContents: [ :stream | 
			| line |
			line := self format: aViennaNode first.
			(self needsIndent: line)
				ifTrue: [ 
					stream nextPut: line.
					line := '' ].
			2 to: aViennaNode size do: [ :index | 
				| element |
				element := self format: (aViennaNode at: index).
				(self needsIndent: element)
					ifTrue: [ 
						line ifNotEmpty: [ stream nextPut: line ].
						stream nextPut: element.
						line := '' ]
					ifFalse: [ 
						| origLine |
						origLine := line.
						line := line , (line ifNotEmpty: [ ' * ' ]) , element.
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
	^ ' *' , String cr join: lines