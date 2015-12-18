pattern matching
match: aBlock1 conc: aBlock2
	^ [ :value | 
	(value isSequence and: [ value notEmpty ])
		ifTrue: [ 
			Array
				new: 16
				streamContents: [ :stream | 
					0 to: value size do: [ :index | 
						| seq1 seq2 |
						seq1 := value copyFrom: 1 to: index.
						seq2 := value copyFrom: index + 1 to: value size.
						(aBlock1 value: seq1)
							ifNotEmpty: [ :bindings1 | 
								(aBlock2 value: seq2)
									ifNotEmpty: [ :bindings2 | 
										bindings1
											do: [ :bind1 | bindings2 do: [ :bind2 | (self aggregateBinding: bind1 with: bind2) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]