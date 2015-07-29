evaluating
evaluate: expression specification: specification states: states vdm10: vdm10 rtc: rtc
	| json response |
	json := Dictionary new.
	states
		keysAndValuesDo: [ :module :binds | binds keysAndValuesDo: [ :var :value | json at: module , '`' , var put: value ] ].
	json at: 'source' put: specification.
	json at: 'expression' put: expression.
	vdm10 = false
		ifTrue: [ json at: 'classic' put: String new ].
	rtc = false
		ifTrue: [ json at: 'ignoreRuntimeChecking' put: String new ].
	http entity: (ZnEntity with: (self stringify: json) type: ZnMimeType applicationJson).
	response := http post.
	json := self parseJson: response.
	^ Array
		with: ((json at: 'message') ifEmpty: [ json at: 'value' ] ifNotEmpty: [ nil ])
		with: (self stateFromJson: json)
		with: (json at: 'message')