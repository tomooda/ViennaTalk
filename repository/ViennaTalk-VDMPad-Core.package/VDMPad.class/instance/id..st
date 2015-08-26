request handling-api
id: anHttpRequest
	| params source states expression result message json |
	params := anHttpRequest mergedFields.
	source := (params at: 'source' ifAbsent: [ String new ]) trimmed.
	states := Dictionary new.
	params
		keysAndValuesDo: [ :k :v | 
			| key value |
			key := k.
			value := v.
			((key includes: $`) and: [ value trimmed notEmpty ])
				ifTrue: [ 
					(states at: (key copyFrom: 1 to: (key indexOf: $`) - 1) ifAbsentPut: [ OrderedCollection new ])
						add:
							(key copyFrom: (key indexOf: $`) + 1 to: key size)
								-> ((value copyReplaceAll: String cr with: ' ') copyReplaceAll: String lf with: ' ') ] ].
	expression := params at: 'expression' ifAbsent: [ String new ].
	result := ((params at: 'value' ifAbsent: [ String new ]) copyReplaceAll: String cr with: ' ')
		copyReplaceAll: String lf
		with: ' '.
	message := params at: 'message' ifAbsent: [ String new ].
	json := Dictionary new.
	json
		at: 'source' put: source;
		at: 'expression' put: expression;
		at: 'value' put: result;
		at: 'message' put: message.
	states
		keysAndValuesDo: [ :moduleName :bindings | bindings do: [ :variableAndValue | json at: moduleName , '`' , variableAndValue key put: variableAndValue value ] ].
	^ self responseJSON: json