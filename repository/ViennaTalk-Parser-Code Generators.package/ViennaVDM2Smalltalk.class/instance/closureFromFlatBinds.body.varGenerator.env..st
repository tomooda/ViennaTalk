utilities
closureFromFlatBinds: anArrayOfPatternNodeAndTypeSetNode body: aString varGenerator: varGenerator env: aDictionary
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPutAll:
						(self closureHeaderFromFlatBinds: anArrayOfPatternNodeAndTypeSetNode varGenerator: varGenerator env: aDictionary);
				nextPutAll: aString;
				nextPutAll: ']' ]