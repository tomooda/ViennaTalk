interpreting
execVDM: aString withArguments: anArray
	^ aString , '(' , (',' join: anArray)
		in: [ :expression | 
			| value |
			value := vdmc plainEvaluate: expression.
			self addFrame: (LWTVDMCallFrame callee: aString expression: expression value: value).
			self addFrame: (LWTVDMStateFrame states: vdmc state).
			value ]