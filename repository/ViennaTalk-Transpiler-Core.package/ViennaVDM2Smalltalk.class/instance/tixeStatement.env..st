code generation-statements
tixeStatement: aViennaNode env: aDictionary
	| patternHandlersNode statementNode |
	patternHandlersNode := aViennaNode first.
	statementNode := aViennaNode second.
	^ self
		stringStreamContents: [ :stream | 
			stream nextPutAll: '(ViennaException tixe: {'.
			1 to: aViennaNode first size by: 2 do: [ :index | 
				| patternNode handlerNode matchVars |
				patternNode := patternHandlersNode at: index.
				handlerNode := patternHandlersNode at: index + 1.
				matchVars := (self boundVariables: patternNode) asArray.
				stream
					nextPutAll: '[:tixe | ';
					nextPutAll: (self generate: patternNode);
					nextPutAll: ' value: tixe] -> [:tixe | '.
				matchVars
					ifNotEmpty: [ stream nextPutAll: '| '.
						matchVars
							do: [ :var | 
								stream
									nextPutAll: var;
									space ].
						stream nextPutAll: '| '.
						matchVars
							do: [ :var | 
								stream
									nextPutAll: var;
									nextPutAll: ' := tixe at: ';
									nextPutAll: var storeString;
									nextPutAll: '. ' ] ].
				stream
					nextPutAll: (self generate: handlerNode env: aDictionary);
					nextPutAll: ']. ' ].
			stream
				nextPutAll: '} in: [';
				nextPutAll: (self generate: statementNode env: aDictionary);
				nextPutAll: '])' ]