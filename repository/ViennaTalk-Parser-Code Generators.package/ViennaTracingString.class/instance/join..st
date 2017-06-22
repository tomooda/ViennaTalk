copying
join: aCollection
	| newSources offset |
	newSources := OrderedCollection
		new:
			(aCollection size - 1) * string size
				+
					(aCollection
						inject: 0
						into: [ :sum :each | sum + (each ifNil: [ 0 ] ifNotNil: [ each size ]) ]).
	offset := 0.
	aCollection
		do: [ :each | 
			each isViennaTracingString
				ifTrue: [ each sources do: [ :assoc | newSources add: assoc key + offset -> assoc value ] ].
			each ifNotNil: [ offset := offset + each size ] ]
		separatedBy: [ sources do: [ :assoc | newSources add: assoc key + offset -> assoc value ].
			offset := offset + string size ].
	^ self class string: (string join: (aCollection collect: #asString)) sources: newSources