evaluating
plainEvaluate: aString ifError: errorBlock
	lock
		critical: [ 
			| preState result postState |
			preState := Dictionary new.
			state
				keysAndValuesDo: [ :key :value | 
					| module var |
					(key includes: $`)
						ifTrue: [ 
							| index |
							index := key indexOf: $`.
							module := key copyFrom: 1 to: index - 1.
							var := key copyFrom: index + 1 to: key size ]
						ifFalse: [ 
							module := 'DEFAULT'.
							var := key ].
					(preState at: module ifAbsentPut: [ Dictionary new ]) at: var put: value ].
			result := engine evaluate: aString specification: self specification states: preState.
			result third ifNotEmpty: [ :msg | ^ errorBlock value: msg ].
			postState := Dictionary new.
			result second
				keysAndValuesDo: [ :module :binds | 
					binds
						keysAndValuesDo: [ :var :value | 
							postState
								at:
									(var = 'DEFAULT'
										ifTrue: [ var ]
										ifFalse: [ module , '`' , var ])
								put: value ] ].
			state := postState.
			^ result first ]