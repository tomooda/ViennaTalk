pattern matching
match: aBlock1 union: aBlock2
	^ [ :value | 
	(value isSet and: [ value notEmpty ])
		ifTrue: [ 
			Array
				new: 16
				streamContents: [ :stream | 
					self
						nonEmptyPowersetOf: value asArray
						withComplementsDo: [ :union1 :union2 | 
							(aBlock1 value: union1 asSet)
								ifNotEmpty: [ :bindings1 | 
									(aBlock2 value: union2 asSet)
										ifNotEmpty: [ :bindings2 | 
											bindings1
												do: [ :bind1 | bindings2 do: [ :bind2 | (self aggregateBinding: bind1 with: bind2) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]