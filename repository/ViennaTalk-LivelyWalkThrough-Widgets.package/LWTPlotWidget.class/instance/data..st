accessing
data: anArrayOfNumber
	anArrayOfNumber isNumber
		ifTrue: [ 
			data := anArrayOfNumber.
			^ self ].
	anArrayOfNumber isCollection
		ifTrue: [ 
			anArrayOfNumber isDictionary
				ifTrue: [ 
					| d |
					d := Dictionary new.
					anArrayOfNumber
						keysAndValuesDo: [ :key :value | 
							(key isNumber and: [ value isNumber ])
								ifTrue: [ d at: key put: value ] ].
					data := d ]
				ifFalse: [ 
					data := anArrayOfNumber
						collect: [ :e | 
							(e isNumber or: [ e isArray and: [ e size = 2 ] ])
								ifTrue: [ e ]
								ifFalse: [ nil ] ] ].
			^ self ].
	data := nil