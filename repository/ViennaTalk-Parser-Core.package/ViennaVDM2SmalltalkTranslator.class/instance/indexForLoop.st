parsers-statements
indexForLoop
	^ super indexForLoop
		==> [ :quin | 
			| ident start end step body |
			ident := quin first.
			start := quin second.
			end := quin third.
			step := quin fourth.
			body := quin fifth.
			String
				new: 1024
				streamContents: [ :stream | 
					stream
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
						nextPutAll: ']' ] ]