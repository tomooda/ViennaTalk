code generation-statements
sequenceForLoop: aViennaNode env: aDictionary
	| pat seqExpr body varGenerator |
	pat := self generate: aViennaNode first env: aDictionary.
	seqExpr := self generate: aViennaNode second env: aDictionary.
	body := self generate: aViennaNode third env: aDictionary.
	varGenerator := self varNameGenerator: 'for' uniqueIn: (Array with: seqExpr with: body) , pat first.
	^ String
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
			stream nextPutAll: ']' ]