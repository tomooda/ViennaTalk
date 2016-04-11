code generation-expressions
casesExpression: aViennaNode env: aDictionary
	| valueExpr patternListAndExpressions defaultExpression varGenerator valueVar foundVar resultVar |
	valueExpr := self generate: aViennaNode first env: aDictionary.
	patternListAndExpressions := self generate: aViennaNode second env: aDictionary.
	defaultExpression := self generate: aViennaNode third env: aDictionary.
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
				with: aViennaNode second asArray
				do: [ :patternListAndExpression :alternativeNode | 
					| patList expr |
					patList := patternListAndExpression first.
					expr := patternListAndExpression second.
					patList
						with: alternativeNode first asArray
						do: [ :pat :patternNode | 
							| vars binder |
							vars := (self boundVariables: patternNode) asArray.
							binder := self binder: pat with: valueVar vars: vars.
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