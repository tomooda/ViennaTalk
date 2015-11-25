pattern matching
matchComposite: aString args: anArrayOfBlock
	^ [ :value | 
	(value isViennaComposite and: [ value size = anArrayOfBlock size and: [ value typeName = aString ] ])
		ifTrue: [ 
			(1 to: anArrayOfBlock size)
				inject: (Array with: Dictionary new)
				into: [ :bindings :index | 
					bindings
						ifEmpty: [ bindings ]
						ifNotEmpty: [ 
							((anArrayOfBlock at: index) value: (value at: index))
								ifEmpty: [ Array new ]
								ifNotEmpty: [ :newBinds | 
									| nextBindings |
									nextBindings := Array
										new: bindings size * newBinds size
										streamContents: [ :stream | 
											bindings
												do: [ :binding | newBinds do: [ :newBind | (self aggregateBinding: binding with: newBind) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]