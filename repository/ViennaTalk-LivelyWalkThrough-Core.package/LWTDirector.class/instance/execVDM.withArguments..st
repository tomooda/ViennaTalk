interpreting
execVDM: aString withArguments: anArray
	^ aString , '(' , (',' join: anArray) , ')'
		in: [ :expression | 
			| value |
			value := [ self vdmc plainEvaluate: expression ]
				on: Error
				do: [ :ex | self abort: 'VDM error: ' , ex messageText ].	"self addFrame: (LWTVDMCallFrame callee: aString expression: expression value: value).
			self addFrame: (LWTVDMStateFrame states: self vdmc state)."
			value ]