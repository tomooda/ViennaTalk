utilities
methodFromOperation: opName fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode body: aString varGenerator: varGenerator env: aDictionary
	^ String
		new: 1024
		streamContents: [ :stream | 
			| tmpVars matchPatternNodes isFirstArg tuplePattern matchVars |
			tmpVars := OrderedCollection new.
			matchPatternNodes := OrderedCollection new.
			stream nextPutAll: opName.
			anArrayOfPatternNodeAndTypeSetNode isEmpty
				ifTrue: [ stream nextPutAll: ': ' , varGenerator value ].
			isFirstArg := true.
			self
				fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode
				patternNodeAndSetOrTypeNodeAndBindTypesDo: [ :patternNode :setNode :bindType | 
					bindType = #identifier
						ifTrue: [ 
							isFirstArg
								ifFalse: [ stream nextPutAll: ' _' ].
							stream
								nextPutAll: ':';
								nextPutAll: patternNode first ].
					bindType = #compound
						ifTrue: [ 
							| tmpVar |
							tmpVar := varGenerator value.
							tmpVars add: tmpVar.
							matchPatternNodes add: patternNode.
							isFirstArg
								ifFalse: [ stream nextPutAll: ' _' ].
							stream
								nextPutAll: ':';
								nextPutAll: tmpVar ].
					isFirstArg := false ].
			tuplePattern := ViennaNode label: 'TuplePattern' with: (ViennaNode label: 'PatternList' withAll: matchPatternNodes).
			matchVars := (self boundVariables: tuplePattern) asArray.
			matchVars notEmpty
				ifTrue: [ 
					stream
						cr;
						nextPutAll: ' | '.
					matchVars
						do: [ :var | 
							stream
								nextPutAll: var;
								nextPut: Character space ].
					stream
						nextPutAll: '| ';
						nextPutAll:
								(self binder: (self generate: tuplePattern env: aDictionary) with: '{' , (' . ' join: tmpVars) , '}' vars: matchVars);
						nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ].
			stream
				cr;
				nextPutAll: aString ]