request handling-api
test: anHttpRequest
	| json vdm10 rtc source prestates expression expectedPoststates expectedValue states triple actualValue actualPoststates diff |
	json := NeoJSONReader fromString: anHttpRequest contents.
	vdm10 := (json at: 'classic' ifAbsent: [ false ]) = false.
	rtc := (json at: 'ignoreRuntimeChecking' ifAbsent: [ false ]) = false.
	source := json at: 'source'.
	prestates := json at: 'prestates' ifAbsent: [ Dictionary new ].
	expression := ((json at: 'expression' ifAbsent: [ String new ]) copyReplaceAll: String cr with: ' ')
		copyReplaceAll: String lf
		with: ' '.
	expectedValue := json at: 'value' ifAbsent: [  ].
	expectedPoststates := json at: 'poststates' ifAbsent: [  ].
	states := Dictionary new.
	prestates
		keysAndValuesDo: [ :key :value | 
			((key includes: $`) and: [ value withBlanksTrimmed notEmpty ])
				ifTrue: [ 
					(states at: (key copyFrom: 1 to: (key indexOf: $`) - 1) ifAbsentPut: [ Dictionary new ])
						at: (key copyFrom: (key indexOf: $`) + 1 to: key size)
						put: ((value copyReplaceAll: String cr with: ' ') copyReplaceAll: String lf with: ' ') ].
			prestates add: key -> value ].
	triple := self engine
		evaluate: expression
		specification: source
		states: states
		vdm10: vdm10
		rtc: rtc.
	diff := Array new writeStream.
	actualValue := triple first.
	actualValue
		ifNil: [ diff nextPut: triple third ]
		ifNotNil: [ 
			actualValue ~= expectedValue
				ifTrue: [ diff nextPut: 'RESUT=' , actualValue , ' (excepted ' , expectedValue , ')' ].
			actualPoststates := Dictionary new.
			triple second
				keysAndValuesDo: [ :moduleName :bindings | bindings keysAndValuesDo: [ :var :val | actualPoststates at: moduleName , '`' , var put: val ] ].
			expectedPoststates
				keysAndValuesDo: [ :key :value | 
					| actual |
					actual := actualPoststates at: key ifAbsent: [  ].
					actual ~= value
						ifTrue: [ diff nextPut: key , '=' , actual , ' (expected ' , value , ')' ] ] ].
	diff := diff contents.
	^ self responseJSON: (diff ifEmpty: [ true ] ifNotEmpty: [ diff ])