formatting-definitions
patternTypePairList: aViennaNode
	^ String
		new: 1024
		streamContents: [ :stream | 
			aViennaNode
				ifNotEmpty: [ 1 to: aViennaNode size - 2 by: 2 do: [ :index | 
						stream
							nextPutAll: (self format: (aViennaNode at: index));
							nextPutAll: ':';
							nextPutAll: (self format: (aViennaNode at: index + 1));
							nextPutAll: ', ' ].
					stream
						nextPutAll: (self format: (aViennaNode at: aViennaNode size - 1));
						nextPutAll: ':';
						nextPutAll: (self format: (aViennaNode at: aViennaNode size)) ] ]