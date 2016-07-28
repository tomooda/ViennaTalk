utilities
closureFromFlatBinds: anArrayOfPatternNodeAndTypeSetNode body: aString varGenerator: varGenerator env: aDictionary
	^ String
		new: 1024
		streamContents: [ :stream | 
			| tmpVars argVars matchPatternNodes tuplePattern matchVars |
			tmpVars := OrderedCollection new.
			argVars := OrderedCollection new.
			matchPatternNodes := OrderedCollection new.
			stream nextPutAll: '['.
			self
				fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode
				patternNodeAndSetOrTypeNodeAndBindTypesDo: [ :patternNode :setNode :bindType | 
					bindType = #identifier
						ifTrue: [ 
							stream
								nextPutAll: ' :';
								nextPutAll: (argVars add: (patternNode first ifNil: [ varGenerator value ])) ].
					bindType = #compound
						ifTrue: [ 
							| tmpVar |
							tmpVar := varGenerator value.
							tmpVars add: tmpVar.
							argVars add: tmpVar.
							matchPatternNodes add: patternNode.
							stream
								nextPutAll: ' :';
								nextPutAll: tmpVar ] ].
			tuplePattern := ViennaNode label: 'TuplePattern' with: (ViennaNode label: 'PatternList' withAll: matchPatternNodes).
			matchVars := (self boundVariables: tuplePattern) asArray.
			anArrayOfPatternNodeAndTypeSetNode ifNotEmpty: [ stream nextPutAll: ' | ' ].
			matchVars notEmpty
				ifTrue: [ 
					stream nextPutAll: ' | '.
					matchVars
						do: [ :var | 
							stream
								nextPutAll: var;
								nextPut: Character space ].
					stream nextPutAll: '| ' ].
			1 to: argVars size do: [ :index | 
				| arg type |
				arg := argVars at: index.
				type := (anArrayOfPatternNodeAndTypeSetNode at: index) second.
				(type notNil and: [ runtimeTypeCheck = true ])
					ifTrue: [ stream nextPutAll: (self generateCheck: arg type: (self generate: type env: aDictionary)) ] ].
			matchVars notEmpty
				ifTrue: [ 
					stream
						nextPutAll:
								(self binder: (self generate: tuplePattern env: aDictionary) with: '{' , (' . ' join: tmpVars) , '}' vars: matchVars);
						nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ].
			stream
				nextPutAll: aString;
				nextPutAll: ']' ]