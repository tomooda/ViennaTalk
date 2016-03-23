request handling
apiCall: apiName in: moduleName withArguments: args
	| evalString result resultJson |
	evalString := moduleName ifNil: [ apiName ] ifNotNil: [ moduleName , '`' , apiName ].
	result := self
		plainEvaluate: evalString , '(' , (',' join: args) , ')'
		ifError: [ :msg | ^ self responseServerError: evalString , String cr , String cr , msg ].
	resultJson := self translateToJson: result.
	resultJson isPetitFailure
		ifTrue: [ ^ self responseServerError: resultJson printString , ' : ' , result asString ].
	^ self
		responseOk:
			((ZnStringEntity type: ZnMimeType applicationJson)
				string: resultJson;
				yourself)