Class {
	#name : #ViennaNode,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'parent',
		'start',
		'end',
		'annotations'
	],
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaNode class >> empty [

	^ self new: 0
]

{ #category : #testing }
ViennaNode class >> isAbstract [

	^ self = ViennaNode
]

{ #category : #'instance creation' }
ViennaNode class >> with: aViennaNode [

	| node |
	node := self new: 1.
	node at: 1 put: aViennaNode.
	^ node
]

{ #category : #'instance creation' }
ViennaNode class >> withAll: anArrayOfViennaNode [

	| node |
	node := self new: anArrayOfViennaNode size.
	1 to: anArrayOfViennaNode size do: [ :index |
	node at: index put: (anArrayOfViennaNode at: index) ].
	^ node
]

{ #category : #comparing }
ViennaNode >> = aViennaNode [

	self class = aViennaNode class ifFalse: [ ^ false ].
	self size = aViennaNode size.
	1 to: self size do: [ :index |
		(self at: index) = (aViennaNode at: index) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #'adding/removing' }
ViennaNode >> add: anObject [

	| array |
	array := self asArray copyWith: anObject.
	self become: ((self class new: array size)
			 parent: parent;
			 start: start end: end;
			 yourself).
	1 to: array size do: [ :index |
	self at: index put: (array at: index) ].
	^ anObject
]

{ #category : #'adding/removing' }
ViennaNode >> addAll: aCollection [

	| array |
	array := self asArray , aCollection.
	self become: ((self class new: array size)
			 parent: parent;
			 start: start end: end;
			 yourself).
	1 to: array size do: [ :index |
	self at: index put: (array at: index) ].
	^ aCollection
]

{ #category : #'adding/removing' }
ViennaNode >> addAnnotation: aString [

	annotations := annotations ifNil: [ { aString } ] ifNotNil: [ 
		               (annotations includes: aString)
			               ifTrue: [ annotations ]
			               ifFalse: [ annotations copyWith: aString ] ].
	^ aString
]

{ #category : #enumerating }
ViennaNode >> allDescendantsDo: aBlock [
	aBlock value: self.
	self
		do: [ :node | 
			node isViennaNode
				ifTrue: [ node allDescendantsDo: aBlock ] ]
]

{ #category : #enumerating }
ViennaNode >> allDescendantsSuchThat: aBlock1 do: aBlock2 [

	self allDescendantsDo: [ :node |
		(aBlock1 value: node) ifTrue: [ aBlock2 value: node ] ]
]

{ #category : #accessing }
ViennaNode >> allParents [
	^ Array
		streamContents: [ :stream | 
			| node |
			node := parent.
			[ node notNil ]
				whileTrue: [ stream nextPut: node.
					node := node parent ] ]
]

{ #category : #enumerating }
ViennaNode >> allSatisfy: aBlock [
	self
		do: [ :node | 
			(aBlock value: node)
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #accessing }
ViennaNode >> annotations [

	^ annotations
]

{ #category : #accessing }
ViennaNode >> annotations: anArrayOfString [

	annotations := anArrayOfString
]

{ #category : #enumerating }
ViennaNode >> anySatisfy: aBlockClosure [
	self
		do: [ :child | 
			(aBlockClosure value: child)
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'accessing-definitions' }
ViennaNode >> asAccessDefinition [

	^ nil
]

{ #category : #converting }
ViennaNode >> asArray [
	| array |
	array := Array new: self size.
	1 to: self size do: [ :i | array at: i put: (self at: i) ].
	^ array
]

{ #category : #'accessing-definitions' }
ViennaNode >> asExport [

	^ nil
]

{ #category : #'accessing-definitions' }
ViennaNode >> asExportSignature [

	self asExport ifNotNil: [ :export |
		(export isViennaTypeNameExportNode or: [
			 export isViennaTypeStructExportNode ]) ifTrue: [
			^ ViennaExportTypesSignatureNode with: export ].
		export isViennaValueExportNode ifTrue: [
			^ ViennaExportValuesSignatureNode with: export ].
		export isViennaFunctionExportNode ifTrue: [
			^ ViennaExportFunctionsSignatureNode with: export ].
		export isViennaOperationExportNode ifTrue: [
			^ ViennaExportOperationsSignatureNode with: export ] ].
	^ nil
]

{ #category : #'accessing-definitions' }
ViennaNode >> asImportDefinitionIn: moduleNode [

	^ nil
]

{ #category : #accessing }
ViennaNode >> at: anInteger put: anObject [

	anObject isViennaNode ifTrue: [ anObject parent: self ].
	^ super at: anInteger put: anObject
]

{ #category : #'accessing-definitions' }
ViennaNode >> bindHolderNode [

	(parent notNil and: [ self isViennaPatternBindNode ]) ifTrue: [
		^ parent bindHolderNode ].
	^ self
]

{ #category : #testing }
ViennaNode >> bindsIdentifier: aString [

	self boundIdentifiersDo: [ :identifier |
		identifier = aString ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #private }
ViennaNode >> boundIdentifiersDo: aBlock [

	^ self subclassResponsibility
]

{ #category : #enumerating }
ViennaNode >> collect: aBlock [
	^ (1 to: self size) collect: [ :index | aBlock value: (self at: index) ]
]

{ #category : #copying }
ViennaNode >> copyFragment [
	^ self shallowCopy postCopyFragment
]

{ #category : #copying }
ViennaNode >> copyWhole [
	| map |
	map := IdentityDictionary new.
	self root copyWhole: map.
	^ map at: self ifAbsent: [ nil ]
]

{ #category : #copying }
ViennaNode >> copyWhole: aDictionary [
	| copy |
	copy := self shallowCopy.
	aDictionary at: self put: copy.
	1 to: copy size do: [ :index | 
		| node |
		node := copy at: index.
		copy
			at: index
			put:
				(node isViennaNode
					ifTrue: [ node copyWhole: aDictionary ]
					ifFalse: [ node copy ]) ].
	^ copy
]

{ #category : #'accessing-definitions' }
ViennaNode >> deepFindResolverForIdentifier: aString [

	| resolver node |
	resolver := self findResolverForIdentifier: aString.
	resolver ifNil: [ ^ nil ].
	node := resolver lookupIdentifier: aString.
	node isViennaImportNode ifTrue: [
		(self moduleNamed: node moduleIdentifier) ifNotNil: [ :module |
			^ module deepFindResolverForIdentifier: node identifier ] ].
	^ resolver
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionOfGlobalName: shortName module: moduleName [

	self module interface importDefinitionList ifNotNil: [
		:importDefinitionList |
		importDefinitionList do: [ :importDef |
			importDef moduleIdentifier = moduleName ifTrue: [
				importDef importModuleSignature isViennaImportModuleSignatureNode
					ifTrue: [
						importDef importModuleSignature do: [ :imports |
							imports do: [ :import |
								import name identifier = shortName ifTrue: [ ^ import ] ] ] ] ] ] ].
	^ nil
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionOfLocalName: aString [

	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #enumerating }
ViennaNode >> detect: aBlock [
	self do: [ :node | (aBlock value: node) ifTrue: [ ^node ] ].
	^ NotFound signalFor: self
]

{ #category : #enumerating }
ViennaNode >> detect: aBlock ifNone: errorBlock [
	self
		do: [ :node | 
			(aBlock value: node)
				ifTrue: [ ^ node ] ].
	^ errorBlock value
]

{ #category : #enumerating }
ViennaNode >> detectParent: aBlock ifNone: errorBlock [

	| node |
	node := self parent.
	[ node notNil ] whileTrue: [
		(aBlock value: node) ifTrue: [ ^ node ].
		node := node parent ].
	^ errorBlock value
]

{ #category : #enumerating }
ViennaNode >> do: aBlock [
	1 to: self size do: [ :index | aBlock value: (self at: index) ]
]

{ #category : #accessing }
ViennaNode >> document [

	^ parent ifNotNil: #document
]

{ #category : #accessing }
ViennaNode >> end [
	^ end
]

{ #category : #'accessing-definitions' }
ViennaNode >> findResolverForIdentifier: aString [

	^ parent ifNotNil: [ parent findResolverForIdentifier: aString ]
]

{ #category : #accessing }
ViennaNode >> first [
	^ self at: 1
]

{ #category : #'pretty printing' }
ViennaNode >> formatWith: aViennaAbstractFormatter [

	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaNode >> fourth [
	^ self at: 4
]

{ #category : #private }
ViennaNode >> freeIdentifiersExcept: aSet do: aBlock [

	^ self subclassResponsibility
]

{ #category : #enumerating }
ViennaNode >> hasDescendantSuchThat: aBlock [
	self allDescendantsDo: [ :n | (aBlock value: n) ifTrue: [ ^true ] ].
	^ false
]

{ #category : #testing }
ViennaNode >> hasFreeIdentifier: aString [

	self
		freeIdentifiersExcept: Set new
		do: [ :identifier | identifier = aString ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
ViennaNode >> hasGlobalReferenceToModule: moduleIdentifier identifier: identifier [

	self
		allDescendantsSuchThat: [ :node |
			node
				isViennaGlobalNameNode: moduleIdentifier
				identifier: identifier ]
		do: [ :node | ^ true ].
	^ false
]

{ #category : #testing }
ViennaNode >> hasScope [

	^ false
]

{ #category : #'accessing-definitions' }
ViennaNode >> hasStatefulReference [

	self uniqueFreeIdentifiersDo: [ :identifier |
		(self resolveIdentifier: identifier) ifNotNil: [ :node |
			(node isViennaStateDefinitionNode or: [
				 node isViennaBlockStatementNode ]) ifTrue: [ ^ true ] ] ].
	^ false
]

{ #category : #comparing }
ViennaNode >> hash [

	^ self
		  inject: self class hash
		  into: [ :hash :node | hash bitXor: node hash ]
]

{ #category : #'pretty printing' }
ViennaNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock3 value
]

{ #category : #controlling }
ViennaNode >> ifEmpty: aBlock [
	^ self isEmpty
		ifTrue: [ aBlock cull: self ]
		ifFalse: [ self ]
]

{ #category : #testing }
ViennaNode >> ifEmpty: emptyBlock ifNotEmpty: nonEmptyBlock [
	^ self isEmpty
		ifTrue: [ emptyBlock value ]
		ifFalse: [ nonEmptyBlock cull: self ]
]

{ #category : #controlling }
ViennaNode >> ifNotEmpty: aBlock [
	^ self isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]
]

{ #category : #testing }
ViennaNode >> ifNotEmpty: nonEmptyBlock ifEmpty: emptyBlock [
	^ self isEmpty
		ifTrue: [ emptyBlock value ]
		ifFalse: [ nonEmptyBlock cull: self ]
]

{ #category : #enumerating }
ViennaNode >> imports [
	^ self module second first
]

{ #category : #enumerating }
ViennaNode >> importsFrom: aString do: aBlock [
	self module second first
		ifNotNil: [ :importDefinitionList | 
			importDefinitionList asArray
				do: [ :importDefinition | 
					importDefinition first = aString
						ifTrue: [ aBlock value: importDefinition second ] ] ]
]

{ #category : #testing }
ViennaNode >> includesParent: aViennaNode [
	self
		parentsDo: [ :node | 
			node = aViennaNode
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #enumerating }
ViennaNode >> inject: anObject into: aBlock [

	| value |
	value := anObject.
	self do: [ :node | value := aBlock value: value value: node ].
	^ value
]

{ #category : #testing }
ViennaNode >> isBlockVariableNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isEmpty [
	^ self size = 0
]

{ #category : #testing }
ViennaNode >> isExportedNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isFunctionDefinition [

	^ false
]

{ #category : #testing }
ViennaNode >> isFunctionNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isLocalValueNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isOperationDefinition [

	^ false
]

{ #category : #testing }
ViennaNode >> isOperationNameNode [

	^ false
]

{ #category : #'accessing-definitions' }
ViennaNode >> isRelocatable [

	self uniqueFreeIdentifiersDo: [ :identifier |
		(self resolveIdentifier: identifier) isViennaTopLevelDefinitionNode
			ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #testing }
ViennaNode >> isStateVariableNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isTypeDefinition [

	^ false
]

{ #category : #testing }
ViennaNode >> isTypeNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isValueDefinition [

	^ false
]

{ #category : #testing }
ViennaNode >> isValueNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaAbstractFunctionTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaAbstractMapTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaAccessFunctionDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaAccessNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaAccessOperationDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaAccessTypeDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaAccessValueDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaAndNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaApplyNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaArithmeticAbsNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaArithmeticDivideNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaArithmeticIntegerDivisionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaArithmeticMinusNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaArithmeticModNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaArithmeticMultiplicationNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaArithmeticPlusNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaArithmeticRemNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaAssignStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaAssignmentDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaAssignmentDefinitionNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaBasicTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaBinaryOperatorExpression [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaBinaryOperatorExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaBindListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaBindNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaBlockStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaCallStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaCasesExpressionAlternativeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaCasesExpressionAlternativesNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaCasesExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaCasesStatementAlternativeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaCasesStatementAlternativesNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaCasesStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaCompositeTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaCompositionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaConditionalExpressionListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaConditionalExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaConditionalStatementListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaConditionalStatementNode [

	^ true
]

{ #category : #testing }
ViennaNode >> isViennaDclStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaDefExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaDefStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaDefinitionBlockNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaDefinitionComponentNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaDistributedMapMergeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaDistributedSequenceConcatenationNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaDistributedSetIntersectionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaDistributedSetUnionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaDocumentNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaEqualDefinitionListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaEqualDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaEqualNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaErrorListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaErrorNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaErrorStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExceptionsNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExists1ExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExistsExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExitStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExplicitFunctionDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExplicitFunctionDefinitionNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExplicitOperationDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExplicitOperationDefinitionNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExportDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExportFunctionsSignatureNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExportModuleSignatureAllNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExportModuleSignatureNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExportOperationsSignatureNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExportTypesSignatureNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExportValuesSignatureNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExportableTopLevelDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExpressionListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExtendedExplicitFunctionDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExtendedExplicitFunctionDefinitionNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExtendedExplicitOperationDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExternalsNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFieldListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFieldNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFieldPatternListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFieldPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFieldReferenceNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFieldSelectNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFinitePowerSetNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFlatDocumnetNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFloorNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaForallExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFunctionDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFunctionDefinitionNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFunctionDefinitionsNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFunctionExportNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFunctionImportNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFunctionImportNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFunctionImportNodeRenamed: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFunctionTypeArgsNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFunctionTypeInstantiationNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFunctionTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaGlobalNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaGlobalNameNode: aString identifier: anotherString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaGreaterThanNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaGreaterThanOrEqualNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIdentifierTypePairListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIdentityStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIfExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIfStatementNode [

	^ true
]

{ #category : #testing }
ViennaNode >> isViennaImplicitFunctionDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaImplicitFunctionDefinitionNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaImplicitOperationBodyNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaImplicitOperationDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaImplicitOperationDefinitionNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaImplyNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaImportDefinitionListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaImportDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaImportFunctionsSignatureNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaImportModuleSignatureAllNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaImportModuleSignatureNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaImportNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaImportNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaImportOperationsSignatureNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaImportSignatureNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaImportTypesSignatureNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaImportValuesSignatureNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaInSetNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIndexForLoopNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaInitialisationNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaInmapTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaInterfaceComponentNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaInterfaceNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaInvariantInitialFunctionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaInvariantNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIotaExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIsBasicExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIsNameExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIsNotYetSpecifiedNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIterateNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLambdaExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLessThanNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLessThanOrEqualNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLetBeExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLetBeStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLetExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLetNode [

	^ self isViennaLetExpressionNode or: [ self isViennaLetStatementNode ]
]

{ #category : #testing }
ViennaNode >> isViennaLetStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLocalDefinitionListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLocalDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLocalNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLocalNameNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLogicalEquivalenceNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapComprehensionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapDomainNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapDomainRestrictedByNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapDomainRestrictedToNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapEnumerationNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapEnumerationPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapInverseNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapMergeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapMunionPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapOrSequenceModifyNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapOrSequenceReferenceNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapRangeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapRangeRestrictedByNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapRangeRestrictedToNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapletListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapletNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapletPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMatchValueNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaModularDocumnetNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaModuleBodyNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaModuleNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaModuleNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMultipleAssignStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMultipleBindNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMultipleBindQuantifierNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMultipleSeqBindNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMultipleSetBindNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMultipleSetSeqBindNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMultipleTypeBindNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaNameListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaNode [
	^ true
]

{ #category : #testing }
ViennaNode >> isViennaNondeterministicStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaNotEqualNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaNotInSetNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaNotNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaObsoleteNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOldNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOperationBodyNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOperationDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOperationDefinitionNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOperationDefinitionsNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOperationExportNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOperationImportNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOperationImportNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOperationImportNodeRenamed: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOperationTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOptionalTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOrNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOthersExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOthersStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaParameterTypesNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaParametersListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaParametersNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaPartialFunctionTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaPatternBindNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaPatternHolderNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaPatternIdentifierNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaPatternIdentifierNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaPatternListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaPatternTypePairListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaPreconditionExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaProductTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaProperSubsetNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaQuoteTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaRecordConstructorNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaRecordModifierNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaRecordPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaRecordTypeDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaRecordTypeDefinitionNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaResultExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaReturnStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSectionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSeq1TypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSeqBindNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSeqConcPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSeqEnumPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSeqTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceComprehensionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceConcatenateNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceElementsNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceEnumerationNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceForLoopNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceHeadNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceIndicesNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceLengthNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceReverseNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceTailNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSet1TypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetBindNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetCardinalityNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetComprehensionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetDifferenceNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetEnumPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetEnumerationNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetForLoopNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetIntersectionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetRangeExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetSeqBindNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetUnionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetUnionPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaStateDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaStateDesignatorNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSubsequenceNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSubsetNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSymbolicLiteralNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSymbolicLiteralNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTixeStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTokenConstructorNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTopLevelDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTotalFunctionTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTrapStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTrapsNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTupleConstructorNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTuplePatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTupleSelectNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeBindListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeBindNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeDefinitionsNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeExportNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeImportNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeImportNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeImportNodeRenamed: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeJudgementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeNameExportNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeNameNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeStructExportNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeSynonymNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeSynonymNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeVariableIdentifierNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeVariableIdentifierNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeVariableListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeVariableNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeVariableNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaUnaryMinusNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaUnaryOperatorExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaUnaryPlusNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaUnaryTypeConstructorNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaUndefinedExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaUnionTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaUnitTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaValueDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaValueDefinitionsNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaValueExportNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaValueImportNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaValueImportNodeRenamed: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaVarInformationNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaWhileLoopNode [

	^ false
]

{ #category : #accessing }
ViennaNode >> label [

	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaNode >> last [
	^ self at: self size
]

{ #category : #accessing }
ViennaNode >> localName [

	self allDescendantsDo: [ :n |
		n isViennaLocalNameNode ifTrue: [ ^ n ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> lookupIdentifier: aString [

	^ nil
]

{ #category : #accessing }
ViennaNode >> module [

	^ parent ifNotNil: #module
]

{ #category : #accessing }
ViennaNode >> moduleNamed: aString [

	self document do: [ :module |
		(module isViennaModuleNode: aString) ifTrue: [ ^ module ] ].
	^ nil
]

{ #category : #accessing }
ViennaNode >> modulesDo: aBlock [
	self document do: aBlock
]

{ #category : #accessing }
ViennaNode >> ninth [
	^ self at: 9
]

{ #category : #testing }
ViennaNode >> notEmpty [
	^ self isEmpty not
]

{ #category : #'pretty printing' }
ViennaNode >> operatorPrecedence [

	^ 0
]

{ #category : #accessing }
ViennaNode >> parent [
	^ parent
]

{ #category : #accessing }
ViennaNode >> parent: aViennaNode [
	parent := aViennaNode
]

{ #category : #enumerating }
ViennaNode >> parentsDo: aBlock [
	| node |
	node := self.
	[ node notNil ]
		whileTrue: [ 
			aBlock value: node.
			node := node parent ]
]

{ #category : #accessing }
ViennaNode >> patternIdentifierNames [
	^ self patternIdentifiers collect: #first
]

{ #category : #accessing }
ViennaNode >> patternIdentifiers [

	^ Array streamContents: [ :stream |
		  self
			  allDescendantsSuchThat: [ :node |
			  node isViennaPatternIdentifierNode ]
			  do: [ :node | stream nextPut: node ] ]
]

{ #category : #copying }
ViennaNode >> postCopyFragment [
	1 to: self size do: [ :index | 
		| node |
		node := self at: index.
		self
			at: index
			put:
				(node isViennaNode
					ifTrue: [ node copyFragment ]
					ifFalse: [ node copy ]) ]
]

{ #category : #printing }
ViennaNode >> printOn: aStream [

	| substrings |
	aStream
		nextPut: $(;
		nextPutAll: self label asString;
		nextPut: Character space.
	substrings := self collect: #printString.
	((substrings contains: [ :string | string includes: Character cr ])
		 or: [ ({ 0 } , (substrings collect: #size)) sum > 50 ])
		ifTrue: [
			substrings do: [ :string |
				aStream nextPut: Character cr.
				string lines
					do: [ :line |
						aStream
							nextPutAll: '  ';
							nextPutAll: line ]
					separatedBy: [ aStream nextPut: Character cr ] ] ]
		ifFalse: [
			substrings
				do: [ :string | aStream nextPutAll: string ]
				separatedBy: [ aStream nextPut: Character space ] ].
	aStream nextPut: $)
]

{ #category : #enumerating }
ViennaNode >> referenceNodesDo: aBlock [

	self
		allDescendantsSuchThat: [ :node |
		node isViennaNameNode or: [ node isViennaOldNameNode ] ]
		do: aBlock
]

{ #category : #'adding/removing' }
ViennaNode >> remove: anObject [

	| array |
	array := self asArray copyWithout: anObject.
	self become: ((self class new: array size)
			 parent: parent;
			 start: start end: end;
			 yourself).
	1 to: array size do: [ :index |
	self at: index put: (array at: index) ].
	^ anObject
]

{ #category : #'adding/removing' }
ViennaNode >> removeAfterIndex: anInteger [

	| array |
	array := self asArray copyFrom: 1 to: anInteger - 1.
	self become: ((self class new: array size)
			 parent: parent;
			 start: start end: end;
			 yourself).
	1 to: array size do: [ :index |
	self at: index put: (array at: index) ].
	^ anInteger
]

{ #category : #'adding/removing' }
ViennaNode >> removeAll: aCollection [

	aCollection ifNotEmpty: [
		| array |
		array := self asArray copyWithoutAll: aCollection.
		self become: ((self class new: array size)
				 parent: parent;
				 start: start end: end;
				 yourself).
		1 to: array size do: [ :index |
		self at: index put: (array at: index) ] ].
	^ aCollection
]

{ #category : #'adding/removing' }
ViennaNode >> removeAnnotation: aString [

	annotations ifNotNil: [ 
		annotations := annotations copyWithout: aString.
		annotations ifEmpty: [ annotations := nil ] ].
	^ aString
]

{ #category : #'accessing-definitions' }
ViennaNode >> resolve [

	^ nil
]

{ #category : #'accessing-definitions' }
ViennaNode >> resolveIdentifier: aString [

	^ (self deepFindResolverForIdentifier: aString) ifNotNil: [ :resolver |
		  resolver lookupIdentifier: aString ]
]

{ #category : #enumerating }
ViennaNode >> reverseDo: aBlock [
	self size to: 1 by: -1 do: [ :index | aBlock value: (self at: index) ]
]

{ #category : #accessing }
ViennaNode >> root [
	^ parent ifNil: [ self ] ifNotNil: #root
]

{ #category : #enumerating }
ViennaNode >> scopesDo: aBlock [

	| node |
	node := self.
	[ node notNil ] whileTrue: [
		node hasScope ifTrue: [ aBlock cull: node ].
		node := node parent ]
]

{ #category : #accessing }
ViennaNode >> second [
	^ self at: 2
]

{ #category : #enumerating }
ViennaNode >> select: aBlock [

	^ Array streamContents: [ :stream |
		  self do: [ :child |
			  (aBlock value: child) ifTrue: [ stream nextPut: child ] ] ]
]

{ #category : #accessing }
ViennaNode >> seventh [
	^ self at: 7
]

{ #category : #'accessing-definitions' }
ViennaNode >> shortName [

	^ nil
]

{ #category : #accessing }
ViennaNode >> sixth [
	^ self at: 6
]

{ #category : #accessing }
ViennaNode >> start [
	^ start
]

{ #category : #accessing }
ViennaNode >> start: anInteger1 end: anInteger2 [
	start := anInteger1.
	end := anInteger2
]

{ #category : #accessing }
ViennaNode >> stateVariablesDo: aBlock [

	(self detectParent: #isViennaDefinitionBlockNode ifNone: [ ^ self ])
		parent do: [ :node |
		node definition isViennaStateDefinitionNode ifTrue: [
			node definition fieldList do: [ :field |
				aBlock value: field identifier ] ] ]
]

{ #category : #accessing }
ViennaNode >> third [
	^ self at: 3
]

{ #category : #'accessing-definitions' }
ViennaNode >> uniqueBoundIdentifiers [

	| identifiers |
	identifiers := Set new.
	self boundIdentifiersDo: [ :identifier | identifiers add: identifier ].
	^ identifiers asArray
]

{ #category : #enumerating }
ViennaNode >> uniqueBoundIdentifiersDo: aBlock [

	| done |
	done := Set new.
	self boundIdentifiersDo: [ :identifier |
		(done includes: identifier) ifFalse: [
			done add: identifier.
			aBlock value: identifier ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> uniqueFreeIdentifiers [

	| identifiers |
	identifiers := Set new.
	self
		freeIdentifiersExcept: Set new
		do: [ :identifier | identifiers add: identifier ].
	^ identifiers asArray
]

{ #category : #enumerating }
ViennaNode >> uniqueFreeIdentifiersDo: aBlock [

	| done |
	done := Set new.
	self freeIdentifiersExcept: Set new do: [ :identifier |
		(done includes: identifier) ifFalse: [
			done add: identifier.
			aBlock value: identifier ] ]
]
