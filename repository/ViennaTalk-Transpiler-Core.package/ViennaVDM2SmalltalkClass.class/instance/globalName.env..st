code generation-expressions
globalName: aViennaNode env: aDictionary
	^ aDictionary
		at: aViennaNode first , '`' , aViennaNode second
		ifAbsent: [ (aDictionary at: aViennaNode first ifAbsent: [ aViennaNode first ]) , String space , aViennaNode second ]