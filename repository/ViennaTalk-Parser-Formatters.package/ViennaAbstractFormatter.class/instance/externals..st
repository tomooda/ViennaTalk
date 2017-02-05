formatting-definitions
externals: aViennaNode
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPutAll: 'ext'.
			aViennaNode
				do: [ :varInfo | 
					stream
						space;
						nextPutAll: (self format: varInfo) ] ]