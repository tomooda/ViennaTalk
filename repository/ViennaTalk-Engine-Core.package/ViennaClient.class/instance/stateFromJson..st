private
stateFromJson: aDictionary
	| states |
	states := Dictionary new.
	aDictionary
		keysAndValuesDo: [ :key :value | 
			(key includes: $`)
				ifTrue: [ 
					| index module var |
					index := key indexOf: $`.
					module := key copyFrom: 1 to: index - 1.
					var := key copyFrom: index + 1 to: key size.
					(states at: module ifAbsentPut: [ Dictionary new ]) at: var put: value ] ].
	^ states