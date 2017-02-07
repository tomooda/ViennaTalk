formatting-definitions
parameterTypes: aViennaNode
	^ '('
		,
			(aViennaNode first
				ifNil: [ '' ]
				ifNotNil: [ :node | self format: node ]) , ')'