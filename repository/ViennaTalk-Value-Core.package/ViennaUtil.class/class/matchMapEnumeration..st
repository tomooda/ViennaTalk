pattern matching
matchMapEnumeration: anArrayOfPairOfBlock
	^ [ :value | 
	(value isDictionary and: [ value size = anArrayOfPairOfBlock size ])
		ifTrue: [ 
			value
				ifEmpty: [ Array with: Dictionary new ]
				ifNotEmpty: [ 
					| keys bindingsMatrix sizes |
					keys := value keys asArray.
					bindingsMatrix := anArrayOfPairOfBlock
						collect: [ :pair | 
							| keyBlock valueBlock |
							keyBlock := pair first.
							valueBlock := pair second.
							Array
								new: keys size
								streamContents: [ :stream | 
									1 to: keys size do: [ :memberIndex | 
										(keyBlock value: (keys at: memberIndex))
											ifNotEmpty: [ :keyBinds | 
												(valueBlock value: (value at: (keys at: memberIndex)))
													ifNotEmpty: [ :valueBinds | 
														(Array
															new: 4
															streamContents: [ :stream0 | 
																keyBinds
																	do: [ :keyBind | 
																		valueBinds
																			do: [ :valueBind | (self aggregateBinding: keyBind with: valueBind) ifNotNil: [ :bind | stream0 nextPut: bind ] ] ] ])
															ifNotEmpty: [ :binds | stream nextPut: memberIndex -> binds ] ] ] ] ] ].
					sizes := bindingsMatrix collect: #size.
					(sizes includes: 0)
						ifTrue: [ Array new ]
						ifFalse: [ 
							Array
								new: 16
								streamContents: [ :stream | 
									| decode |
									decode := nil.
									decode := [ :n :blockIndex | 
									| p |
									p := sizes at: blockIndex.
									(blockIndex = sizes size
										ifTrue: [ #() ]
										ifFalse: [ decode value: n // p value: blockIndex + 1 ]) copyWithFirst: n \\ p + 1 ].
									0 to: (sizes inject: 1 into: [ :p :s | p * s ]) - 1 do: [ :n | 
										| indices |
										indices := decode value: n value: 1.
										((1 to: indices size)
											collect: [ :blockIndex | ((bindingsMatrix at: blockIndex) at: (indices at: blockIndex)) key ]) asSet size
											= indices size
											ifTrue: [ 
												stream
													nextPutAll:
														((1 to: indices size)
															inject: (Array with: Dictionary new)
															into: [ :bindings :blockIndex | 
																bindings
																	ifEmpty: [ bindings ]
																	ifNotEmpty: [ 
																		| assoc memberIndex binds nextBindings |
																		assoc := (bindingsMatrix at: blockIndex) at: (indices at: blockIndex).
																		memberIndex := assoc key.
																		binds := assoc value.
																		nextBindings := Array
																			new: bindings size * binds size
																			streamContents: [ :stream0 | 
																				bindings
																					do: [ :binding | binds do: [ :bind | (self aggregateBinding: binding with: bind) ifNotNil: [ :b | stream0 nextPut: b ] ] ] ] ] ]) ] ] ] ] ] ]
		ifFalse: [ Array new ] ]