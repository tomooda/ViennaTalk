code generation-expressions
globalName: aViennaNode env: aDictionary
	^ aDictionary
		at: aViennaNode first , '`' , aViennaNode second
		ifAbsent: [ aViennaNode first , String space , aViennaNode second ]