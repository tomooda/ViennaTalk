formatting-statements
traps: aViennaNode
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPutAll: '{'.
			aViennaNode
				ifNotEmpty: [ stream
						nextPutAll:
							(',' , String cr
								join:
									((1 to: aViennaNode size by: 2)
										collect: [ :index | 
											(self format: (aViennaNode at: index)) , ' |-> '
												, (self indentString: (self format: (aViennaNode at: index + 1))) ])) ].
			stream nextPutAll: '}' ]