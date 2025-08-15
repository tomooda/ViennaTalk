Class {
	#name : 'ViennaTranspilerForExecutionTracing',
	#superclass : 'ViennaVDM2SmalltalkObject',
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Transpiler',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Transpiler'
}

{ #category : 'utilities' }
ViennaTranspilerForExecutionTracing >> afterMultipleAssignment: aViennaMultipleAssignmentStatementNode [

	^ 'self _multipleStatesChanged: #(' , (' ' join:
		   (aViennaMultipleAssignmentStatementNode collect: [ :assign |
			    assign stateDesignator identifier ])) , ')'
]

{ #category : 'utilities' }
ViennaTranspilerForExecutionTracing >> defineMethodFromOperation: opName in: theClass protocol: protocolString fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode body: bodyString pre: preString post: postString retVar: retVarName retType: typeNode varGenerator: varGenerator env: aDictionary node: aViennaNode bodyNode: aViennaNode2 [

	| tmpVars matchPatternNodes isFirstArg tuplePattern matchVars argVars formalArgs |
	tmpVars := OrderedCollection new.
	matchPatternNodes := OrderedCollection new.
	argVars := OrderedCollection new.
	formalArgs := OrderedCollection new.
	self
		defineMethod: (self stringStreamContents: [ :stream |
					 stream nextPutAll: opName.
					 anArrayOfPatternNodeAndTypeSetNode isEmpty ifTrue: [
						 stream nextPutAll: ': ' , varGenerator value ].
					 isFirstArg := true.
					 self
						 fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode
						 patternNodeAndSetOrTypeNodeAndBindTypesDo: [
								 :patternNode
								 :setNode
								 :bindType |
								 bindType = #identifier ifTrue: [
										 argVars add: patternNode identifier.
										 isFirstArg ifFalse: [ stream nextPutAll: ' _' ].
										 formalArgs add: patternNode identifier -> setNode.
										 stream
											 nextPutAll: ':';
											 nextPutAll: patternNode identifier ].
								 bindType = #compound ifTrue: [
										 | tmpVar |
										 argVars addAll: patternNode uniqueBoundIdentifiers.
										 tmpVar := varGenerator value.
										 tmpVars add: tmpVar.
										 formalArgs add: tmpVar -> setNode.
										 matchPatternNodes add: patternNode.
										 isFirstArg ifFalse: [ stream nextPutAll: ' _' ].
										 stream
											 nextPutAll: ':';
											 nextPutAll: tmpVar ].
								 isFirstArg := false ].
					 tuplePattern := ViennaTuplePatternNode patternList:
						                 (ViennaPatternListNode keepParentsWithAll:
							                  matchPatternNodes).
					 matchVars := tuplePattern uniqueBoundIdentifiers.
					 stream cr.
					 matchVars
						 ifEmpty: [
						 stream nextPutAll: '| _oldState ' , retVarName , ' |' ]
						 ifNotEmpty: [
								 stream nextPutAll: ' | _oldState ' , retVarName , ' '.
								 matchVars do: [ :var |
										 stream
											 nextPutAll: var;
											 nextPut: Character space ].
								 stream
									 nextPutAll: '| ';
									 nextPutAll: (self
											  binder: (self generate: tuplePattern env: aDictionary)
											  with: '{' , (' . ' join: tmpVars) , '}'
											  vars: matchVars);
									 nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ].
					 stream
						 cr;
						 nextPutAll: '_document _recordOperationCall:';
						 nextPutAll: opName storeString;
						 nextPutAll: ' module: ';
						 nextPutAll: aViennaNode module identifier storeString;
						 nextPutAll: ' args: {';
						 nextPutAll: (' . ' join: (formalArgs collect: #key));
						 nextPutAll: '}.';
						 cr.
					 runtimeTypeCheck = true ifTrue: [
							 formalArgs
								 with: anArrayOfPatternNodeAndTypeSetNode
								 do: [ :assoc :triple |
										 stream nextPutAll:
											 ('((' , (self generate: assoc value env: aDictionary)
											  , ') includes: ' , assoc key
											  , ') ifFalse: [ViennaRuntimeTypeError signal].'
												  asViennaTracingString: triple second) ] ].
					 preString ifNotNil: [
							 (preString isArray
								  ifTrue: [ preString ]
								  ifFalse: [ { preString } ]) do: [ :pre |
									 stream nextPutAll:
										 ('(' , pre
										  , ') ifFalse: [ViennaPreconditionViolation signal].'
											  asViennaTracingString:
												  (pre asViennaTracingString sources
													   ifNotEmpty: [ :sources | sources last value ]
													   ifEmpty: [ aViennaNode ])) ] ].
					 stream
						 nextPutAll: '_oldState := self state. ';
						 nextPutAll:
							 (retVarName , ' := self _' , opName , ((' _: ' join: argVars)
									   ifNotEmpty: [ :str | '_: ' , str ]
									   ifEmpty: [ '' ]) , '.' asViennaTracingString: aViennaNode).
					 (runtimeTypeCheck = true and: [
						  typeNode isViennaUnitTypeNode not ]) ifTrue: [
							 stream nextPutAll:
								 ('(' , (self generate: typeNode env: aDictionary)
								  , ' includes: ' , retVarName
								  , ') ifFalse: [ViennaRuntimeTypeError signal].'
									  asViennaTracingString: typeNode) ].
					 postString ifNotNil: [
							 (postString isArray
								  ifTrue: [ postString ]
								  ifFalse: [ { postString } ]) do: [ :post |
									 stream nextPutAll:
										 ('(' , post
										  , ') ifFalse: [ViennaPostconditionViolation signal].'
											  asViennaTracingString:
												  (post asViennaTracingString sources
													   ifNotEmpty: [ :sources | sources last value ]
													   ifEmpty: [ aViennaNode ])) ] ].
					 stream cr.
					 stream
						 nextPutAll: '_document _recordOperationReturn: ';
						 nextPutAll: opName storeString;
						 nextPutAll: ' module: ';
						 nextPutAll: aViennaNode module identifier storeString;
						 nextPutAll: ' value: ';
						 nextPutAll: retVarName;
						 nextPutAll: '.';
						 cr.
					 stream nextPutAll: '^ ' , retVarName ])
		in: theClass
		protocol: protocolString
		node: aViennaNode.
	^ self
		  defineMethod: ((self stringStreamContents: [ :stream |
					    stream
						    nextPut: $_;
						    nextPutAll: opName.
					    argVars do: [ :var |
							    stream
								    nextPutAll: '_: ';
								    nextPutAll: var;
								    nextPutAll: ' ' ].
					    stream
						    cr;
						    nextPutAll: bodyString ]) asViennaTracingString:
				   aViennaNode2)
		  in: theClass
		  protocol: protocolString
		  node: aViennaNode2
]

{ #category : 'class access' }
ViennaTranspilerForExecutionTracing >> documentBaseClass [

	^ ViennaTranspiledModularDocumentForExecutionTracing
]

{ #category : 'class access' }
ViennaTranspilerForExecutionTracing >> moduleBaseClass [

	^ ViennaTranspiledObjectForExecutionTracing
]

{ #category : 'instance creation' }
ViennaTranspilerForExecutionTracing >> newStateVariableSlotNamed: aString [

	^ ViennaStateVariableSlotForExecutionTracing named: aString asSymbol
]
