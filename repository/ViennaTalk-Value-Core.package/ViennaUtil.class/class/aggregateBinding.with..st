private
aggregateBinding: aDictionary1 with: aDictionary2
	| dict |
	dict := aDictionary1 copy.
	aDictionary2
		keysAndValuesDo: [ :key :value | 
			(dict includesKey: key)
				ifTrue: [ 
					(dict at: key) = value
						ifFalse: [ ^ nil ] ]
				ifFalse: [ dict at: key put: value ] ].
	^ dict