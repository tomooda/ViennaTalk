code generation-statements
sequenceForLoop: aViennaNode env: aDictionary
	| guard patNode pat seqExpr body vars varGenerator |
	guard := nil.
	patNode := aViennaNode first.
	(#('TypeBind' 'SetBind' 'SeqBind') includes: patNode label)
		ifTrue: [ 
			guard := self generate: patNode second env: aDictionary.
			patNode := patNode first ].
	pat := self generate: patNode env: aDictionary.
	seqExpr := self generate: aViennaNode second env: aDictionary.
	body := self generate: aViennaNode third env: aDictionary.
	patNode label = 'PatternIdentifier'
		ifTrue: [ 
			^ seqExpr , ' do: [:' , patNode first , ' | '
				,
					(guard
						ifNil: [ '' ]
						ifNotNil: [ '(' , guard , ' includes: ' , patNode first , ') ifFalse: [ViennaBindingViolation signal].' ]) , body
				, ']' ].
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
				nextPutAll:
						(guard ifNil: [ '' ] ifNotNil: [ '(' , guard , ' includes: ' , loopVar , ') ifFalse: [ViennaBindingViolation signal].' ]);
				nextPutAll: (self binder: pat with: loopVar vars: vars);
				nextPutAll: ' ifFalse: [ViennaNoMatch signal].'.
			stream nextPutAll: body.
			stream nextPutAll: ']' ]