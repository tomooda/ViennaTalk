parsers-statements
sequenceForLoop
	^ super sequenceForLoop
		==> [ :triple | 
			| pat seqExpr body varGenerator |
			pat := triple first.
			seqExpr := triple second.
			body := triple third.
			varGenerator := self varNameGenerator: 'for' uniqueIn: (Array with: seqExpr with: body) , pat first.
			String
				new: 1024
				streamContents: [ :stream | 
					| loopVar |
					loopVar := varGenerator value.
					stream
						nextPutAll: seqExpr;
						nextPutAll: ' do: [:';
						nextPutAll: loopVar;
						nextPutAll: '||';
						nextPutAll: (' ' join: pat first);
						nextPutAll: '|';
						nextPutAll: (self binder: pat second with: loopVar vars: pat first);
						nextPutAll: ' ifFalse: [ViennaNoMatch signal].'.
					stream nextPutAll: body.
					stream nextPutAll: ']' ] ]