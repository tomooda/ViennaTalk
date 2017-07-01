code generation-statements
returnStatement: aViennaNode env: aDictionary
	^ 'thisContext viennaReturn: ' , (aViennaNode first ifNil: ['nil'] ifNotNil: [:arg | (self generate: arg env: aDictionary)])