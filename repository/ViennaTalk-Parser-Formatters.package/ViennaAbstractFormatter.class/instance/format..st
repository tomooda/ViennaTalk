formatting
format: aViennaNode
	| string |
	aViennaNode isString
		ifTrue: [ ^ aViennaNode ].
	string := self perform: (aViennaNode label uncapitalized , ':') asSymbol with: aViennaNode.
	self needsParen
		ifTrue: [ string := '(' , (self indentString: string) , ')' ].
	^ string