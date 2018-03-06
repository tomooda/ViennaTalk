code generation-statements
returnStatement: aViennaNode env: aDictionary
	^ '^ '
		,
			(aViennaNode first
				ifNil: [ ' self' ]
				ifNotNil: [ :arg | self generate: arg env: aDictionary ])