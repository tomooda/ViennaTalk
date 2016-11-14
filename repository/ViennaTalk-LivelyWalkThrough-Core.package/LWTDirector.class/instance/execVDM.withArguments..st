interpreting
execVDM: aString withArguments: anArray
	^ aString , '(' , (',' join: anArray) , ')'
		in: [ :expression | 
			| value |
			value := [ self animation plainEvaluate: expression ]
				on: Error
				do: [ :ex | self abort: 'VDM error: ' , ex messageText ].	
			value ]