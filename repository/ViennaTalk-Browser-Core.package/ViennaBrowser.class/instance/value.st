value pane
value
	^ self selectedModule
		ifNil: [ 
			self selectedField
				ifNil: [ 
					'{'
						,
							(',' , String cr join: (vdmc state keys asSortedCollection collect: [ :key | key , ' |-> ' , (vdmc plainAt: key) ]))
						, '}' ]
				ifNotNil: [ :field | vdmc plainAt: field ifAbsent: [ String new ] ] ]
		ifNotNil: [ :module | 
			self selectedField
				ifNil: [ 
					| prefix |
					prefix := module , '`'.
					'{'
						,
							(',' , String cr
								join:
									(vdmc state keys
										select: [ :key | (key copyFrom: 1 to: prefix size) = prefix ]
										thenCollect: [ :key | (key copyFrom: prefix size + 1 to: key size) , ' |-> ' , (vdmc plainAt: key) ])
										asSortedCollection) , '}' ]
				ifNotNil: [ :field | vdmc plainAt: module , '`' , field ifAbsent: [ String new ] ] ]