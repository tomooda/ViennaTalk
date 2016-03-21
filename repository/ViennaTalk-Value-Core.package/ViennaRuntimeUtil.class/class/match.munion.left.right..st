pattern matching
match: aBlock1 munion: aBlock2 left: anInteger1 right: anInteger2
	^ [ :dict | 
	(dict isDictionary and: [ dict size = (anInteger1 + anInteger2) ])
		ifTrue: [ 
			| value size generator |
			value := dict keys asArray.
			size := value size.
			generator := [ :block | 1 to: size do: [ :i | block value: (Array with: i) ] ].
			anInteger1 - 1
				timesRepeat: [ 
					generator := [ :g | [ :block | g value: [ :is | is last + 1 to: size do: [ :i | block value: (is copyWith: i) ] ] ] ]
						value: generator ].
			Array
				new: 16
				streamContents: [ :stream | 
					generator
						value: [ :is | 
							| dict1 dict2 |
							dict1 := Dictionary new: size.
							dict2 := Dictionary new: size.
							1 to: size do: [ :i | 
								(is includes: i)
									ifTrue: [ dict1 at: (value at: i) put: (dict at: (value at: i)) ]
									ifFalse: [ dict2 at: (value at: i) put: (dict at: (value at: i)) ] ].
							(aBlock1 value: dict1)
								ifNotEmpty: [ :bindings1 | 
									(aBlock2 value: dict2)
										ifNotEmpty: [ :bindings2 | 
											bindings1
												do: [ :bind1 | bindings2 do: [ :bind2 | (self aggregateBinding: bind1 with: bind2) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]