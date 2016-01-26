code generation
generate: aViennaNode
	aViennaNode isString
		ifTrue: [ ^ aViennaNode ].
	^ self perform: (aViennaNode label uncapitalized , ':') asSymbol with: aViennaNode