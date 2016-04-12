code generation-statements
returnStatement: aViennaNode env: aDictionary
	^ '^ ' , (self generate: aViennaNode first env: aDictionary)