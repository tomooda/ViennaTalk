code generation-statements
indexForLoop: aViennaNode env: aDictionary
	| ident start end step body |
	ident := self generate: aViennaNode first env: aDictionary.
	start := self generate: aViennaNode second env: aDictionary.
	end := self generate: aViennaNode third env: aDictionary.
	step := self generate: aViennaNode fourth env: aDictionary.
	body := self generate: aViennaNode fifth env: aDictionary.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPut: Character space;
				nextPutAll: start;
				nextPutAll: ' to: ';
				nextPutAll: end.
			step
				ifNotNil: [ 
					stream
						nextPutAll: ' by: ';
						nextPutAll: step ].
			stream
				nextPutAll: ' do: [:';
				nextPutAll: ident;
				nextPutAll: '|';
				nextPutAll: body;
				nextPutAll: ']' ]