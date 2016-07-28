code generation-definitions
assignmentDefinition: aViennaNode env: aDictionary
	^ aViennaNode third
		ifNotNil: [ 
			aViennaNode first , ' := ' , (self generate: aViennaNode third env: aDictionary)
				,
					((runtimeTypeCheck = true and: [ aViennaNode second notNil ])
						ifTrue: [ '.' , (self generateCheck: aViennaNode first type: (self generate: aViennaNode second env: aDictionary)) ]
						ifFalse: [ '' ]) ]