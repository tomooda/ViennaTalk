evaluating
basicPlainEvaluate: aString in: moduleName ifError: errorBlock
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
					module := self defaultModule.
					var := key ].
			(preState at: module ifAbsentPut: [ Dictionary new ]) at: var put: value ].
	result := engine
		evaluate: aString
		specification: self specification
		states: preState
		module: moduleName.
	result third
		ifNotEmpty: [ 
			result := engine
				evaluate: aString
				specification: self specification
				states: Dictionary new
				module: moduleName.
			result third ifNotEmpty: [ :msg | ^ errorBlock value: msg ] ].
	postState := Dictionary new.
	result second
		keysAndValuesDo: [ :module :binds | 
			binds
				keysAndValuesDo: [ :var :value | 
					postState
						at:
							(var = self defaultModule
								ifTrue: [ var ]
								ifFalse: [ module , '`' , var ])
						put: value ] ].
	state := postState.
	^ result first