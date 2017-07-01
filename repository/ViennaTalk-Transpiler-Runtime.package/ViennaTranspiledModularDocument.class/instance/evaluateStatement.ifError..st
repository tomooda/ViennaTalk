evaluating
evaluateStatement: aString ifError: errorBlock
	^ self evaluateStatement: aString with: ViennaVDM2SmalltalkClass new ifError: errorBlock