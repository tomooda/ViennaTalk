formatting-definitions
explicitOperationDefinition: aViennaNode
	| identifier1 operationType identifier2 parameters expression pre post  |
	identifier1 := self format: aViennaNode first.
	operationType := self format: aViennaNode second.
	identifier2 := self format: aViennaNode third.
	parameters := self format: aViennaNode fourth.
	expression := self format: aViennaNode fifth.
	pre := aViennaNode sixth ifNotNil: [ self format: aViennaNode seventh ] ifNil: [ '' ].
	post := aViennaNode seventh ifNotNil: [ self format: aViennaNode eighth ] ifNil: [ '' ].
	^ identifier1 , ' : ' , operationType , String cr , identifier2 , parameters , ' =='
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ]) , (pre ifNotEmpty: [ String cr , 'pre ' , pre ])
		, (post ifNotEmpty: [ String cr , 'post ' , post ])