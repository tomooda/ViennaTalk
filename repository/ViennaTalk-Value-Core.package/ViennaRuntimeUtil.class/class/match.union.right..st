pattern matching
match: aBlock1 union: aBlock2 right: anInteger
	^ [ :set | 
	(set isSet and: [ set notEmpty ])
		ifTrue: [ 
			| value size generator |
			value := set asArray.
			size := value size.
			generator := [ :block | 1 to: size do: [ :i | block value: (Array with: i) ] ].
			anInteger - 1
				timesRepeat: [ 
					generator := [ :g | [ :block | g value: [ :is | is last + 1 to: size do: [ :i | block value: (is copyWith: i) ] ] ] ]
						value: generator ].
			Array
				new: 16
				streamContents: [ :stream | 
					generator
						value: [ :is | 
							| set1 set2 |
							set1 := Set new: size.
							set2 := Set new: size.
							1 to: size do: [ :i | 
								(is includes: i)
									ifTrue: [ set2 add: (value at: i) ]
									ifFalse: [ set1 add: (value at: i) ] ].
							(aBlock1 value: set1)
								ifNotEmpty: [ :bindings1 | 
									(aBlock2 value: set2)
										ifNotEmpty: [ :bindings2 | 
											bindings1
												do: [ :bind1 | bindings2 do: [ :bind2 | (self aggregateBinding: bind1 with: bind2) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]