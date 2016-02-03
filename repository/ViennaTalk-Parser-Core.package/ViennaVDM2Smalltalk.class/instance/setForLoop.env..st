code generation-statements
setForLoop: aViennaNode env: aDictionary
	| pat setExpr body varGenerator |
	pat := self generate: aViennaNode first env: aDictionary.
	setExpr := self generate: aViennaNode second env: aDictionary.
	body := self generate: aViennaNode third env: aDictionary.
	varGenerator := self varNameGenerator: 'for' uniqueIn: (Array with: setExpr with: body) , pat first.
	^ String
		new: 1024
		streamContents: [ :stream | 
			| loopVar |
			loopVar := varGenerator value.
			stream
				nextPutAll: setExpr;
				nextPutAll: ' asSortedCollection do: [:';
				nextPutAll: loopVar;
				nextPutAll: '||';
				nextPutAll: (' ' join: pat first);
				nextPutAll: '|';
				nextPutAll: (self binder: pat second with: loopVar vars: pat first);
				nextPutAll: ' ifFalse: [ViennaNoMatch signal].'.
			stream nextPutAll: body.
			stream nextPutAll: ']' ]