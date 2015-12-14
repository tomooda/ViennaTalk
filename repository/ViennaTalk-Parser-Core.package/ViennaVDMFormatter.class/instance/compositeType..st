formatting-types
compositeType: aViennaNode
	| constructor fields |
	constructor := self format: aViennaNode first.
	fields := self format: aViennaNode second.
	^ 'compose ' , constructor , ' of'
		,
			((self needsIndent: constructor , fields)
				ifTrue: [ (self newlineIndentString: fields) , String cr ]
				ifFalse: [ String space , fields , String space ]) , 'end'