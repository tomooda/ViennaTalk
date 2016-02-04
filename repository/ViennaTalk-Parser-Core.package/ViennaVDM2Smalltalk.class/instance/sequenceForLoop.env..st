code generation-statements
sequenceForLoop: aViennaNode env: aDictionary
	| pat seqExpr body vars varGenerator |
	pat := self generate: aViennaNode first env: aDictionary.
	seqExpr := self generate: aViennaNode second env: aDictionary.
	body := self generate: aViennaNode third env: aDictionary.
	aViennaNode first label = 'PatternIdentifier'
		ifTrue: [ ^ seqExpr , ' do: [:' , aViennaNode first first , ' | ' , body , ']' ].
	vars := (self boundVariables: aViennaNode first) asArray.
	varGenerator := self varNameGenerator: 'for' uniqueIn: (Array with: seqExpr with: body) , vars.
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
				nextPutAll: (' ' join: vars);
				nextPutAll: '|';
				nextPutAll: (self binder: pat with: loopVar vars: vars);
				nextPutAll: ' ifFalse: [ViennaNoMatch signal].'.
			stream nextPutAll: body.
			stream nextPutAll: ']' ]