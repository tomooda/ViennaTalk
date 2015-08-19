request handling-api
eval: aZnRequest
	| vdm10 rtc params source module expression states triple json |
	params := aZnRequest contentType = ZnMimeType applicationJson
		ifTrue: [ NeoJSONReader fromString: aZnRequest entity ]
		ifFalse: [ aZnRequest mergedFields ].
	self halt.
	vdm10 := (params at: 'classic' ifAbsent: [  ]) isNil.
	rtc := (params at: 'ignoreRuntimeChecking' ifAbsent: [  ]) isNil.
	source := (params at: 'source' ifAbsent: [ String new ]) trimmed.
	module := params at: 'module' ifAbsent: [ 'DEFAULT' ].
	states := Dictionary new.
	params
		keysAndValuesDo: [ :k :v | 
			| key value |
			key := k.
			value := v.
			((key includes: $`) and: [ value trimmed notEmpty ])
				ifTrue: [ 
					(states at: (key copyFrom: 1 to: (key indexOf: $`) - 1) ifAbsentPut: [ Dictionary new ])
						at: (key copyFrom: (key indexOf: $`) + 1 to: key size)
						put: ((value copyReplaceAll: String cr with: ' ') copyReplaceAll: String lf with: ' ') ] ].
	expression := ((params at: 'expression' ifAbsent: [ String new ]) copyReplaceAll: String cr with: ' ')
		copyReplaceAll: String lf
		with: ' '.
	triple := self engine
		evaluate: expression
		specification: source
		states: states
		module: module
		vdm10: vdm10
		rtc: rtc.	"self log: anHttpRequest remoteHost source: source states: states
	expression: expression value: triple first message: triple third."
	json := Dictionary new.
	json
		at: 'source' put: source;
		at: 'expression' put: expression;
		at: 'value' put: (triple first ifNil: [ String new ]);
		at: 'message' put: (triple third).
	triple second
		keysAndValuesDo: [ :moduleName :bindings | bindings keysAndValuesDo: [ :varName :value | json at: moduleName , '`' , varName put: value ] ].
	^ self responseJSON: json