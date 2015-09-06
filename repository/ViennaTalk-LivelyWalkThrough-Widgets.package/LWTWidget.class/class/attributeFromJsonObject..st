json
attributeFromJsonObject: anObject
	anObject isDictionary
		ifFalse: [ ^ anObject ].
	anObject
		at: 'storeString'
		ifPresent: [ :storeString | 
			[ ^ Compiler evaluate: storeString ]
				on: Error
				do: [ :ex | 
					^ anObject
						at: 'onError'
						ifPresent: [ :alternative | 
							[ Compiler evaluate: alternative ]
								on: Error
								do: [ :ex2 | nil ] ]
						ifAbsent: [  ] ] ].
	^ anObject