code generation-statements
returnStatement: aViennaNode env: aDictionary
	^ 'thisContext viennaReturn: ' , (self generate: aViennaNode first)