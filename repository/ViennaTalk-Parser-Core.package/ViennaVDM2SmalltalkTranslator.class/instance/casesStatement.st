parsers-statements
casesStatement
	^ super casesStatement
		==> [ :triple | 
			| valueExpr defaultSpatternListAndStatement defaultStatement varGenerator valueVar foundVar resultVar |
			valueExpr := triple first.
			defaultSpatternListAndStatement := triple second.
			defaultStatement := triple third.
			varGenerator := self
				varNameGenerator: 'cases'
				uniqueIn:
					(Array with: valueExpr with: (defaultStatement ifNil: [ '' ])) , (defaultSpatternListAndStatement collect: #second).
			valueVar := varGenerator value.
			foundVar := varGenerator value.
			resultVar := varGenerator value.
			String
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
					defaultSpatternListAndStatement
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
						nextPutAll: (defaultStatement ifNil: [ 'ViennaNoMatch signal' ]);
						nextPutAll: '].';
						nextPutAll: resultVar;
						nextPutAll: '])' ] ]