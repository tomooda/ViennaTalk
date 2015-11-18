parsers-definitions
explicitFunctionDefinition
	^ super explicitFunctionDefinition
		==> [ :array | 
			{(array first).
			(String
				new: 1024
				streamContents: [ :stream | 
					array fifth
						do: [ :args | 
							stream nextPut: $[.
							args
								do: [ :arg | 
									stream
										nextPutAll: ' :';
										nextPutAll: arg ].
							stream nextPut: $| ].
					stream nextPutAll: array sixth.
					array fifth do: [ :args | stream nextPut: $] ] ])} ]