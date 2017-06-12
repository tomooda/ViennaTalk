utilities
defineMethodFromOperation: opName in: theClass protocol: protocolString fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode body: bodyString pre: preString post: postString retVar: retVarName retType: typeNode varGenerator: varGenerator env: aDictionary node: aViennaNode
	| tmpVars matchPatternNodes isFirstArg tuplePattern matchVars argVars formalArgs |
	tmpVars := OrderedCollection new.
	matchPatternNodes := OrderedCollection new.
	argVars := OrderedCollection new.
	formalArgs := OrderedCollection new.
	self
		defineMethod:
			(String
				new: 1024
				streamContents: [ :stream | 
					stream nextPutAll: opName.
					anArrayOfPatternNodeAndTypeSetNode isEmpty
						ifTrue: [ stream nextPutAll: ': ' , varGenerator value ].
					isFirstArg := true.
					self
						fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode
						patternNodeAndSetOrTypeNodeAndBindTypesDo: [ :patternNode :setNode :bindType | 
							bindType = #identifier
								ifTrue: [ argVars add: patternNode first.
									isFirstArg
										ifFalse: [ stream nextPutAll: ' _' ].
									formalArgs add: patternNode first -> setNode.
									stream
										nextPutAll: ':';
										nextPutAll: patternNode first ].
							bindType = #compound
								ifTrue: [ | tmpVar |
									argVars addAll: (self boundVariables: patternNode).
									tmpVar := varGenerator value.
									tmpVars add: tmpVar.
									formalArgs add: tmpVar -> setNode.
									matchPatternNodes add: patternNode.
									isFirstArg
										ifFalse: [ stream nextPutAll: ' _' ].
									stream
										nextPutAll: ':';
										nextPutAll: tmpVar ].
							isFirstArg := false ].
					tuplePattern := ViennaNode
						label: 'TuplePattern'
						with: (ViennaNode label: 'PatternList' withAll: matchPatternNodes).
					matchVars := (self boundVariables: tuplePattern) asArray.
					stream cr.
					matchVars
						ifEmpty: [ stream nextPutAll: '| _oldState ' , retVarName , ' |' ]
						ifNotEmpty: [ stream nextPutAll: ' | _oldState ' , retVarName , ' '.
							matchVars
								do: [ :var | 
									stream
										nextPutAll: var;
										nextPut: Character space ].
							stream
								nextPutAll: '| ';
								nextPutAll:
									(self
										binder: (self generate: tuplePattern env: aDictionary)
										with: '{' , (' . ' join: tmpVars) , '}'
										vars: matchVars);
								nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ].
					runtimeTypeCheck = true
						ifTrue: [ formalArgs
								do: [ :assoc | 
									stream
										nextPutAll: '((';
										nextPutAll: (self generate: assoc value env: aDictionary);
										nextPutAll: ') includes: ';
										nextPutAll: assoc key;
										nextPutAll: ') ifFalse: [ViennaRuntimeTypeError signal].' ] ].
					preString
						ifNotNil: [ stream
								nextPutAll: '(';
								nextPutAll: preString;
								nextPutAll: ') ifFalse: [ViennaPreconditionViolation signal].' ].
					stream
						nextPutAll: '_oldState := self state. ';
						nextPutAll: retVarName , ' := self _';
						nextPutAll: opName.
					argVars
						do: [ :var | 
							stream
								nextPutAll: '_: ';
								nextPutAll: var;
								nextPutAll: ' ' ].
					stream nextPutAll: '.'.
					(runtimeTypeCheck = true and: [ typeNode label ~= 'UnitType' ])
						ifTrue: [ stream
								nextPutAll: '(';
								nextPutAll: (self generate: typeNode env: aDictionary);
								nextPutAll: ' includes: ' , retVarName , ') ifFalse: [ViennaRuntimeTypeError signal].' ].
					postString
						ifNotNil: [ stream
								nextPutAll: '(';
								nextPutAll: postString;
								nextPutAll: ') ifFalse: [ViennaPostconditionViolation signal].' ].
					stream nextPutAll: '^ ' , retVarName ])
		in: theClass
		protocol: protocolString
		node: aViennaNode.
	^ self
		defineMethod:
			(String
				new: 1024
				streamContents: [ :stream | 
					stream
						nextPut: $_;
						nextPutAll: opName.
					argVars
						do: [ :var | 
							stream
								nextPutAll: '_: ';
								nextPutAll: var;
								nextPutAll: ' ' ].
					stream
						cr;
						nextPutAll: bodyString ])
		in: theClass
		protocol: protocolString
		node: aViennaNode fourth