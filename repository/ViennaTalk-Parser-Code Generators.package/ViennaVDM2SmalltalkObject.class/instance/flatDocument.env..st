code generation-definitions
flatDocument: aViennaNode env: aDictionary
	^ (super flatDocument: aViennaNode env: aDictionary) ifNotNil: [ :anonymousClass | anonymousClass new ]