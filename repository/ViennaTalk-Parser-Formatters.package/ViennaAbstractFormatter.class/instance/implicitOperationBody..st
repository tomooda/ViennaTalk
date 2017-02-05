formatting-definitions
implicitOperationBody: aViennaNode
	^ String
		new: 1024
		streamContents: [ :stream | 
			aViennaNode first
				ifNotNil: [ :externals | 
					stream
						cr;
						nextPutAll: (self format: externals) ].
			aViennaNode second
				ifNotNil: [ :pre | 
					stream
						cr;
						nextPutAll: 'pre ';
						nextPutAll: (self format: pre) ].
			aViennaNode third
				ifNotNil: [ :post | 
					stream
						cr;
						nextPutAll: 'post ';
						nextPutAll: (self format: post) ]
				ifNil: [ String new ].
			aViennaNode fourth
				ifNotNil: [ :exceptions | 
					stream
						cr;
						nextPutAll: (self format: exceptions) ] ]