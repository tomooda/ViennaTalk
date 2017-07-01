evaluating
evaluateExpression: aString ifError: errorBlock
	^ self evaluateExpression: aString with: ViennaVDM2SmalltalkClass new ifError: errorBlock