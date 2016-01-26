code generation-expressions
casesExpression: aViennaNode
	| valueExpr patternListAndExpressions defaultExpression varGenerator valueVar foundVar resultVar |
	valueExpr := self generate: aViennaNode first.
	patternListAndExpressions := self generate: aViennaNode second.
	defaultExpression := aViennaNode third ifNotNil: [ :node | self generate: node ].
	varGenerator := self
		varNameGenerator: 'cases'
		uniqueIn:
			(Array with: valueExpr with: (defaultExpression ifNil: [ '' ])) , (patternListAndExpressions collect: #second).
	valueVar := varGenerator value.
	foundVar := varGenerator value.
	resultVar := varGenerator value.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPutAll: '(';
				nextPutAll: valueExpr;
				nextPutAll: ' in: [:';
				nextPutAll: valueVar;
				nextPutAll: '||';
				nextPutAll: foundVar;
				nextPutAll: ' ';
				nextPutAll: resultVar;
				nextPutAll: '| ';
				nextPutAll: foundVar;
				nextPutAll: ' := false.'.
			patternListAndExpressions
				do: [ :patternListAndExpression | 
					| patList expr |
					patList := patternListAndExpression first.
					expr := patternListAndExpression second.
					patList
						do: [ :pat | 
							| vars binder |
							vars := pat first.
							binder := self binder: pat second with: valueVar vars: vars.
							stream
								nextPutAll: foundVar;
								nextPutAll: ' ifFalse: [|';
								nextPutAll: (' ' join: vars);
								nextPutAll: '| ';
								nextPutAll: binder;
								nextPutAll: ' ifTrue: [';
								nextPutAll: foundVar;
								nextPutAll: ' := true.';
								nextPutAll: resultVar;
								nextPutAll: ' := ';
								nextPutAll: expr;
								nextPutAll: ']].' ] ].
			stream
				nextPutAll: foundVar;
				nextPutAll: ' ifFalse: [';
				nextPutAll: resultVar;
				nextPutAll: ' := ';
				nextPutAll: (defaultExpression ifNil: [ 'ViennaNoMatch signal' ]);
				nextPutAll: '].';
				nextPutAll: resultVar;
				nextPutAll: '])' ]