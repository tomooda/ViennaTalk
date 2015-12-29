commands
statesDo: aBlock ifError: errorBlock
	^ self
		send: 'state'
		responseDo: [ :stateDict | 
			stateDict
				keysAndValuesDo: [ :var :value | 
					(value beginsWithEmpty: 'mk_' , var , '(' caseSensitive: true)
						ifFalse: [ aBlock value: var value: value ] ] ]
		ifError: errorBlock