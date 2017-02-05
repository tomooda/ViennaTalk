formatting-definitions
errorList: aViennaNode
	^ String
		new: 1024
		streamContents: [ :stream | 
			aViennaNode
				do: [ :node | 
					stream
						space;
						nextPutAll: (self format: node) ] ]