pattern matching
matchSetEnumeration: anArrayOfBlock
	^ [ :value | 
	(value isSet and: [ value size = anArrayOfBlock size ])
		ifTrue: [ 
			value
				ifEmpty: [ Array with: Dictionary new ]
				ifNotEmpty: [ 
					| members bindingsMatrix sizes |
					members := value asArray.
					bindingsMatrix := anArrayOfBlock
						collect: [ :block | 
							Array
								new: members size
								streamContents: [ :stream | 1 to: members size do: [ :memberIndex | (block value: (members at: memberIndex)) ifNotEmpty: [ :binds | stream nextPut: memberIndex -> binds ] ] ] ].
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