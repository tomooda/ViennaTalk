formatting-statements
dclStatement: aViennaNode
	| assigns |
	assigns := self formatAll: aViennaNode.
	^ 'dcl'
		,
			((self anyNeedsIndent: assigns)
				ifTrue: [ 
					String cr , indent
						, (self indentAllStrings: assigns withSeparator: ',') ]
				ifFalse: [ String space , (', ' join: assigns) ])