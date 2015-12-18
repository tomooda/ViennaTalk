pattern matching
match: aBlock1 munion: aBlock2
	^ [ :value | 
	(value isDictionary and: [ value notEmpty ])
		ifTrue: [ 
			Array
				new: 16
				streamContents: [ :stream | 
					self
						powersetOf: value keys asArray
						withComplementsDo: [ :keys1 :keys2 | 
							| dict1 dict2 |
							dict1 := Dictionary new: keys1 size.
							keys1 do: [ :key | dict1 at: key put: (value at: key) ].
							dict2 := Dictionary new: keys2 size.
							keys2 do: [ :key | dict2 at: key put: (value at: key) ].
							(aBlock1 value: dict1)
								ifNotEmpty: [ :bindings1 | 
									(aBlock2 value: dict2)
										ifNotEmpty: [ :bindings2 | 
											bindings1
												do: [ :bind1 | bindings2 do: [ :bind2 | (self aggregateBinding: bind1 with: bind2) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]