code generation-definitions
assignmentDefinition: aViennaNode env: aDictionary
	^ aViennaNode third ifNotNil: [ aViennaNode first , ' := ' , (self generate: aViennaNode third env: aDictionary) ]