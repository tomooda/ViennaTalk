enumerating
dataPointsDo: aBlock
	data isNil
		ifTrue: [ ^ self ].
	data isNumber
		ifTrue: [ 
			aBlock value: 0 value: data.
			^ self ].
	(data isSequenceable and: [ data allSatisfy: [ :e | e isArray ] ])
		ifTrue: [ 
			data do: [ :e | aBlock value: e first value: e second ].
			^ self ].
	data keysAndValuesDo: aBlock.
	^ self