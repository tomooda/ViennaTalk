utilities
collectDefinitions: aViennaNode
	^ Array
		new: 32
		streamContents:
			[ :stream | self definitions: aViennaNode do: [ :node | stream nextPut: node ] ]