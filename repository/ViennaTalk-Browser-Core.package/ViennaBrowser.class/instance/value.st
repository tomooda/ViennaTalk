value pane
value
	^ self selectedModule
		ifNil: [ 
			self selectedField
				ifNil: [ 
					'{'
						,
							(',' , String cr join: (animation state keys asSortedCollection collect: [ :key | key , ' |-> ' , (animation plainAt: key) ]))
						, '}' ]
				ifNotNil: [ :field | animation plainAt: field ifAbsent: [ String new ] ] ]
		ifNotNil: [ :module | 
			self selectedField
				ifNil: [ 
					| prefix |
					prefix := module , '`'.
					'{'
						,
							(',' , String cr
								join:
									(animation state keys
										select: [ :key | key size > prefix size and: [(key copyFrom: 1 to: prefix size) = prefix ]]
										thenCollect: [ :key | (key copyFrom: prefix size + 1 to: key size) , ' |-> ' , (animation plainAt: key) ])
										asSortedCollection) , '}' ]
				ifNotNil: [ :field | animation plainAt: module , '`' , field ifAbsent: [ String new ] ] ]