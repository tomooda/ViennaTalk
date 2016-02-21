utilities
generatorFromFlatBinds: anArrayOfPatternNodeAndTypeSetNode selector: aSymbol whenMatchFailed: failString body: aString varGenerator: varGenerator env: aDictionary
	^ String
		new: 1024
		streamContents: [ :stream | 
			| numParens tmpVars matchPatternNodes tuplePattern matchVars |
			numParens := 0.
			tmpVars := OrderedCollection new.
			matchPatternNodes := OrderedCollection new.
			self
				fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode
				patternNodeAndSetOrTypeNodeAndBindTypesDo: [ :patternNode :setNode :bindType | 
					stream
						nextPutAll:
								(setNode label = 'SetRangeExpression'
										ifTrue: [ 
											(aSymbol = #do:
												ifTrue: [ '' ]
												ifFalse: [ '(' ]) , (self intervalExpression: setNode env: aDictionary)
												,
													(aSymbol = #do:
														ifTrue: [ '' ]
														ifFalse: [ ')' ]) ]
										ifFalse: [ self generate: setNode env: aDictionary ]);
						nextPut: Character space;
						nextPutAll: aSymbol;
						nextPutAll: ' [ :'.
					bindType = #identifier
						ifTrue: [ stream nextPutAll: patternNode first ].
					bindType = #compound
						ifTrue: [ 
							| tmpVar |
							tmpVar := varGenerator value.
							tmpVars add: tmpVar.
							matchPatternNodes add: patternNode.
							stream nextPutAll: tmpVar ].
					stream nextPutAll: ' | '.
					numParens := numParens + 1 ].
			tuplePattern := ViennaNode label: 'TuplePattern' with: (ViennaNode label: 'PatternList' withAll: matchPatternNodes).
			matchVars := (self boundVariables: tuplePattern) asArray.
			matchVars notEmpty
				ifTrue: [ 
					stream nextPutAll: ' | '.
					matchVars
						do: [ :var | 
							stream
								nextPutAll: var;
								nextPut: Character space ].
					stream
						nextPutAll: '| ';
						nextPutAll:
								(self binder: (self generate: tuplePattern env: aDictionary) with: '{' , (' . ' join: tmpVars) , '}' vars: matchVars).
					failString
						ifNotNil: [ 
							stream
								nextPutAll: ' ifFalse: [';
								nextPutAll: failString;
								nextPutAll: ']' ].
					stream nextPutAll: ' ifTrue: [ '.
					numParens := numParens + 1 ].
			stream nextPutAll: aString.
			numParens timesRepeat: [ stream nextPut: $] ] ]