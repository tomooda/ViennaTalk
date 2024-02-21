Class {
	#name : #ViennaRefactoring,
	#superclass : #Object,
	#instVars : [
		'ast'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaRefactoring class >> isAbstract [
	^ self = ViennaRefactoring
]

{ #category : #utilities }
ViennaRefactoring class >> on: aViennaNode do: aBlock [
	self
		allSubclassesDo: [ :class | 
			class isAbstract
				ifFalse: [ | refactoring |
					refactoring := class new ast: aViennaNode.
					refactoring check
						ifTrue: [ aBlock value: refactoring ] ] ]
]

{ #category : #utilities }
ViennaRefactoring class >> sortedInstancesOn: aViennaNode [
	^ (Array
		streamContents: [ :stream | 
			self
				on: aViennaNode
				do: [ :refactoring | stream nextPut: refactoring ] ])
		sorted: [ :less :more | less sortingOrder <= more sortingOrder ]
]

{ #category : #'visiting-definitions' }
ViennaRefactoring >> addDefinition: aViennaNode in: moduleNode [

	aViennaNode isViennaAccessTypeDefinitionNode ifTrue: [
		^ self addTypeDefinition: aViennaNode in: moduleNode ].
	aViennaNode isViennaAccessValueDefinitionNode ifTrue: [
		^ self addValueDefinition: aViennaNode in: moduleNode ].
	aViennaNode isViennaAccessFunctionDefinitionNode ifTrue: [
		^ self addFunctionDefinition: aViennaNode in: moduleNode ].
	aViennaNode isViennaAccessOperationDefinitionNode ifTrue: [
		^ self addOperationDefinition: aViennaNode in: moduleNode ].
	aViennaNode isViennaTypeSynonymNode ifTrue: [
		^ self addTypeDefinition: aViennaNode in: moduleNode ].
	aViennaNode isViennaRecordTypeDefinitionNode ifTrue: [
		^ self addTypeDefinition: aViennaNode in: moduleNode ].
	aViennaNode isViennaValueDefinitionNode ifTrue: [
		^ self addValueDefinition: aViennaNode in: moduleNode ].
	aViennaNode isViennaExplicitFunctionDefinitionNode ifTrue: [
		^ self addFunctionDefinition: aViennaNode in: moduleNode ].
	aViennaNode isViennaImplicitFunctionDefinitionNode ifTrue: [
		^ self addFunctionDefinition: aViennaNode in: moduleNode ].
	aViennaNode isViennaExplicitOperationDefinitionNode ifTrue: [
		^ self addOperationDefinition: aViennaNode in: moduleNode ].
	aViennaNode isViennaImplicitOperationDefinitionNode ifTrue: [
		^ self addOperationDefinition: aViennaNode in: moduleNode ].
	^ nil
]

{ #category : #'visiting-definitions' }
ViennaRefactoring >> addFunctionDefinition: aViennaNode in: moduleNode [

	moduleNode addFunctionDefinition: aViennaNode
]

{ #category : #'visiting-definitions' }
ViennaRefactoring >> addOperationDefinition: aViennaNode in: moduleNode [

	moduleNode addOperationDefinition: aViennaNode
]

{ #category : #'visiting-definitions' }
ViennaRefactoring >> addTypeDefinition: aViennaNode in: moduleNode [

	moduleNode addTypeDefinition: aViennaNode
]

{ #category : #'visiting-definitions' }
ViennaRefactoring >> addValueDefinition: aViennaNode in: moduleNode [

	moduleNode addValueDefinition: aViennaNode
]

{ #category : #accessing }
ViennaRefactoring >> ast [
	^ ast
]

{ #category : #accessing }
ViennaRefactoring >> ast: aViennaNode [
	ast := aViennaNode
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString in: aViennaNode do: aBlock [
	| selector |
	aViennaNode isViennaNode
		ifFalse: [ ^ self ].
	selector := ('bindingOf:in' , aViennaNode label , ':do:')
		asSymbol.
	(self respondsTo: selector)
		ifTrue: [ self
				perform: selector
				with: aString
				with: aViennaNode
				with: aBlock ]
		ifFalse: [ aViennaNode
				do: [ :node | self bindingOf: aString in: node do: aBlock ] ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inAssignmentDefinition: aViennaNode do: aBlock [

	aViennaNode identifier = aString ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode do: [ :node |
		self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inError: aViennaNode do: aBlock [

	aViennaNode identifier = aString ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode do: [ :node |
		self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inExplicitFunctionDefinition: aViennaNode do: aBlock [

	aViennaNode identifier = aString ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode do: [ :node |
		self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inExplicitOperationDefinition: aViennaNode do: aBlock [

	aViennaNode identifier = aString ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode do: [ :node |
		self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inImplicitFunctionDefinition: aViennaNode do: aBlock [

	aViennaNode identifier = aString ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode do: [ :node |
		self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inImplicitOperationDefinition: aViennaNode do: aBlock [

	aViennaNode identifier = aString ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode do: [ :node |
		self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inIndexForLoop: aViennaNode do: aBlock [

	aViennaNode identifier = aString ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode do: [ :node |
		self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inPatternIdentifier: aViennaNode do: aBlock [

	aViennaNode identifier = aString ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode do: [ :node |
		self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inRecordTypeDefinition: aViennaNode do: aBlock [

	aViennaNode identifier = aString ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode do: [ :node |
		self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inStateDefinition: aViennaNode do: aBlock [

	aViennaNode identifier = aString ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode second do: [ :field |
		field first = aString ifTrue: [ aBlock value: field ] ].
	aViennaNode do: [ :node |
		self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inTypeSynonym: aViennaNode do: aBlock [

	aViennaNode identifier = aString ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode do: [ :node |
		self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inTypeVariableIdentifier: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #operations }
ViennaRefactoring >> check [
	^ self subclassResponsibility
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> ensureExport: aViennaNode [

	aViennaNode isViennaGlobalNameNode ifTrue: [ ^ aViennaNode ].
	(aViennaNode isViennaLocalNameNode and: [
		 aViennaNode resolve module == aViennaNode module ]) ifTrue: [
		^ self ensureExport: aViennaNode resolve ].
	aViennaNode asExportSignature ifNotNil: [ :signature |
		self ensureExportSignature: signature in: aViennaNode module ].
	^ nil
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> ensureExportSignature: aViennaNode in: moduleNode [

	| exportModuleSignature |
	exportModuleSignature := moduleNode exportDefinition
		                         exportModuleSignature.
	exportModuleSignature isViennaExportModuleSignatureAllNode ifTrue: [
		^ exportModuleSignature ].
	exportModuleSignature reverseDo: [ :exportSignature |
		exportSignature class = aViennaNode class ifTrue: [
			exportSignature add: aViennaNode first.
			^ exportSignature ] ].
	exportModuleSignature add: aViennaNode.
	^ aViennaNode
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> ensureImport: aViennaNode in: moduleNode [

	| importModuleSignature |
	aViennaNode module == moduleNode ifTrue: [ ^ self ].
	importModuleSignature := (self
		                          ensureImportDefinitionFrom:
		                          aViennaNode module identifier
		                          in: moduleNode) second.
	importModuleSignature isViennaImportModuleSignatureAllNode ifTrue: [
		^ self ].
	(aViennaNode asImportDefinitionIn: moduleNode) ifNotNil: [
		:srcImportDefinition |
		srcImportDefinition second do: [ :srcImportSignature |
			| signatures |
			signatures := srcImportSignature asArray asOrderedCollection.
			srcImportSignature asArray do: [ :srcImport |
				(importModuleSignature anySatisfy: [ :importSignature |
					 importSignature class = srcImportSignature class and: [
						 importSignature anySatisfy: [ :import |
							 import name = srcImport name ] ] ]) ifTrue: [
					signatures remove: srcImport ifAbsent: [  ] ] ].
			signatures ifNotEmpty: [
				(self
					 ensureImportSignatureFor: srcImportSignature
					 in: importModuleSignature) addAll: signatures ] ] ]
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> ensureImportDefinitionFrom: aString in: moduleNode [

	| last srcName |
	last := nil.
	srcName := aString isViennaNode
		           ifTrue: [ aString name ]
		           ifFalse: [ aString ].
	moduleNode importsFrom: srcName do: [ :importModuleSignature |
		importModuleSignature isViennaImportModuleSignatureAllNode ifTrue: [
			^ importModuleSignature parent ].
		last := importModuleSignature parent ].
	last ifNil: [
		last := ViennaImportDefinitionNode
			        moduleIdentifier: srcName
			        importModuleSignature:
			        ViennaImportModuleSignatureNode empty.
		moduleNode addImportDefinition: last ].
	^ last
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> ensureImportSignatureFor: importSignatureNode in: importModuleSignatureNode [

	^ importModuleSignatureNode asArray
		  detect: [ :importSignature |
			  importSignature class = importSignatureNode class ]
		  ifNone: [
			  | importSignature |
			  importSignature := importSignatureNode class empty.
			  importModuleSignatureNode add: importSignature.
			  importSignature ]
]

{ #category : #operations }
ViennaRefactoring >> execute [
	^ self subclassResponsibility
]

{ #category : #'visiting-pattern matching' }
ViennaRefactoring >> expressionFromPattern: aViennaNode bindings: aDictionary [

	aViennaNode isViennaPatternIdentifierNode ifTrue: [
		^ aDictionary
			  at: aViennaNode identifier
			  ifPresent: [ :node | node copyFragment ]
			  ifAbsent: [
			  ViennaLocalNameNode identifier: aViennaNode identifier ] ].
	aViennaNode isViennaMapEnumerationPatternNode ifTrue: [
		^ ViennaMapEnumerationNode withAll:
			  (aViennaNode asArray collect: [ :node |
				   node isViennaNode
					   ifTrue: [
					   self expressionFromPattern: node bindings: aDictionary ]
					   ifFalse: [ node ] ]) ].
	aViennaNode isViennaMapMunionPatternNode ifTrue: [
		^ ViennaMapMergeNode withAll:
			  (aViennaNode asArray collect: [ :node |
				   node isViennaNode
					   ifTrue: [
					   self expressionFromPattern: node bindings: aDictionary ]
					   ifFalse: [ node ] ]) ].
	aViennaNode isViennaMapletPatternNode ifTrue: [
		^ ViennaMapletNode withAll: (aViennaNode asArray collect: [ :node |
				   node isViennaNode
					   ifTrue: [
					   self expressionFromPattern: node bindings: aDictionary ]
					   ifFalse: [ node ] ]) ].
	aViennaNode isViennaMatchValueNode ifTrue: [
		^ aViennaNode expression ].
	aViennaNode isViennaRecordPatternNode ifTrue: [
		^ ViennaRecordConstructorNode withAll:
			  (aViennaNode asArray collect: [ :node |
				   node isViennaNode
					   ifTrue: [
					   self expressionFromPattern: node bindings: aDictionary ]
					   ifFalse: [ node ] ]) ].
	aViennaNode isViennaSeqConcPatternNode ifTrue: [
		^ ViennaSequenceConcatenateNode withAll:
			  (aViennaNode asArray collect: [ :node |
				   node isViennaNode
					   ifTrue: [
					   self expressionFromPattern: node bindings: aDictionary ]
					   ifFalse: [ node ] ]) ].
	aViennaNode isViennaSeqEnumPatternNode ifTrue: [
		^ ViennaSequenceEnumerationNode withAll:
			  (aViennaNode asArray collect: [ :node |
				   node isViennaNode
					   ifTrue: [
					   self expressionFromPattern: node bindings: aDictionary ]
					   ifFalse: [ node ] ]) ].
	aViennaNode isViennaSetEnumPatternNode ifTrue: [
		^ ViennaSetEnumerationNode withAll:
			  (aViennaNode asArray collect: [ :node |
				   node isViennaNode
					   ifTrue: [
					   self expressionFromPattern: node bindings: aDictionary ]
					   ifFalse: [ node ] ]) ].
	aViennaNode isViennaSetUnionPatternNode ifTrue: [
		^ ViennaSetUnionNode withAll:
			  (aViennaNode asArray collect: [ :node |
				   node isViennaNode
					   ifTrue: [
					   self expressionFromPattern: node bindings: aDictionary ]
					   ifFalse: [ node ] ]) ].
	aViennaNode isViennaTuplePatternNode ifTrue: [
		^ ViennaTupleConstructorNode withAll:
			  (aViennaNode asArray collect: [ :node |
				   node isViennaNode
					   ifTrue: [
					   self expressionFromPattern: node bindings: aDictionary ]
					   ifFalse: [ node ] ]) ].
	^ self error: 'Unknown pattern syntax'
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString in: aViennaNode do: aBlock [
	| selector |
	aViennaNode isViennaNode
		ifFalse: [ ^ self ].
	selector := ('freeOccurrencesOf:in' , aViennaNode label , ':do:')
		asSymbol.
	(self respondsTo: selector)
		ifTrue: [ self
				perform: selector
				with: aString
				with: aViennaNode
				with: aBlock ]
		ifFalse: [ aViennaNode
				do: [ :node | self freeOccurrencesOf: aString in: node do: aBlock ] ]
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inBlockStatement: aViennaNode do: aBlock [

	aViennaNode first isViennaDclStatementNode ifTrue: [
		self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
		aViennaNode first do: [ :assignmentDefinition |
			assignmentDefinition identifier = aString ifTrue: [ ^ self ] ].
		2 to: aViennaNode size do: [ :index |
			self
				freeOccurrencesOf: aString
				in: (aViennaNode at: index)
				do: aBlock ] ].
	aViennaNode do: [ :node |
		self freeOccurrencesOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inCasesAlternative: aViennaNode do: aBlock [

	self
		freeOccurrencesOf: aString
		in: aViennaNode patternList
		do: aBlock.
	aViennaNode patternList
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ self ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inCasesExpressionAlternative: aViennaNode do: aBlock [
	^ self
		freeOccurrencesOf: aString
		inCasesAlternative: aViennaNode
		do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inCasesStatementAlternative: aViennaNode do: aBlock [
	^ self
		freeOccurrencesOf: aString
		inCasesAlternative: aViennaNode
		do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inDef: aViennaNode do: aBlock [

	aViennaNode equalDefinitionList do: [ :equalDefinition |
		self freeOccurrencesOf: aString in: equalDefinition do: aBlock.
		equalDefinition pattern
			allDescendantsSuchThat: [ :n |
			n isViennaPatternIdentifierNode: aString ]
			do: [ :n | ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inDefExpression: aViennaNode do: aBlock [
	^ self freeOccurrencesOf: aString inDef: aViennaNode do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inDefStatement: aViennaNode do: aBlock [
	^ self freeOccurrencesOf: aString inDef: aViennaNode do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inExists1Expression: aViennaNode do: aBlock [
	^ self
		freeOccurrencesOf: aString
		inSingleQuantifierExpression: aViennaNode
		do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inExistsExpression: aViennaNode do: aBlock [
	^ self
		freeOccurrencesOf: aString
		inFullQuantifierExpression: aViennaNode
		do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inExplicitFunctionDefinition: aViennaNode do: aBlock [

	aViennaNode typeVariableList do: [ :n |
		(n isViennaTypeVariableIdentifierNode: aString) ifTrue: [ ^ self ] ].
	self
		freeOccurrencesOf: aString
		in: aViennaNode typeVariableList
		do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode type do: aBlock.
	self
		freeOccurrencesOf: aString
		in: aViennaNode parametersList
		do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode measure do: aBlock.
	aViennaNode parametersList
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ self ].
	self freeOccurrencesOf: aString in: aViennaNode expression do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode pre do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode post do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inExplicitOperationDefinition: aViennaNode do: aBlock [

	self freeOccurrencesOf: aString in: aViennaNode type do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode parameters do: aBlock.
	aViennaNode statement
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ self ].
	self freeOccurrencesOf: aString in: aViennaNode statement do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode pre do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode post do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inForallExpression: aViennaNode do: aBlock [
	^ self
		freeOccurrencesOf: aString
		inFullQuantifierExpression: aViennaNode
		do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inFullQuantifierExpression: aViennaNode do: aBlock [

	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	aViennaNode first do: [ :multiBind |
		multiBind first do: [ :pattern |
			pattern
				allDescendantsSuchThat: [ :n |
				n isViennaPatternIdentifierNode: aString ]
				do: [ :n | ^ self ] ] ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inFunctionImport: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inImplicitFunctionDefinition: aViennaNode do: aBlock [

	self
		freeOccurrencesOf: aString
		in: aViennaNode typeVariableList
		do: aBlock.
	self
		freeOccurrencesOf: aString
		in: aViennaNode patternTypePairList
		do: aBlock.
	self
		freeOccurrencesOf: aString
		in: aViennaNode identifierTypePairList
		do: aBlock.
	aViennaNode patternTypePairList ifNotEmpty: [ :patternTypePairList |
		1 to: patternTypePairList size by: 2 do: [ :index |
			(patternTypePairList at: index)
				allDescendantsSuchThat: [ :n |
				n isViennaPatternIdentifierNode: aString ]
				do: [ :n | ^ self ] ] ].
	self freeOccurrencesOf: aString in: aViennaNode pre do: aBlock.
	aViennaNode identifierTypePairList ifNotEmpty: [
		:identifierTypePairList |
		1 to: identifierTypePairList size by: 2 do: [ :index |
			(identifierTypePairList at: index) identifier = aString ifTrue: [ ^ self ] ] ].
	self freeOccurrencesOf: aString in: aViennaNode post do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inImplicitOperationDefinition: aViennaNode do: aBlock [

	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock.
	self
		freeOccurrencesOf: aString
		in: aViennaNode fourth first
		do: aBlock.
	self
		freeOccurrencesOf: aString
		in: aViennaNode fourth fourth
		do: aBlock.
	aViennaNode second first ifNotEmpty: [ :patternTypePairList |
		1 to: patternTypePairList size by: 2 do: [ :index |
			(patternTypePairList at: index)
				allDescendantsSuchThat: [ :n |
				n isViennaPatternIdentifierNode: aString ]
				do: [ :n | ^ self ] ] ].
	self
		freeOccurrencesOf: aString
		in: aViennaNode fourth second
		do: aBlock.
	aViennaNode fourth ifNotEmpty: [ :identifierTypePairList |
		1 to: identifierTypePairList size by: 2 do: [ :index |
			(identifierTypePairList at: index) = aString ifTrue: [ ^ self ] ] ].
	self
		freeOccurrencesOf: aString
		in: aViennaNode fourth third
		do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inIndexForLoop: aViennaNode do: aBlock [

	self
		freeOccurrencesOf: aString
		in: aViennaNode startExpression
		do: aBlock.
	self
		freeOccurrencesOf: aString
		in: aViennaNode endExpression
		do: aBlock.
	self
		freeOccurrencesOf: aString
		in: aViennaNode stepExpression
		do: aBlock.
	aViennaNode identifier = aString ifTrue: [ ^ self ].
	self freeOccurrencesOf: aString in: aViennaNode statement do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inInvariantInitialFunction: aViennaNode do: aBlock [

	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	aViennaNode first
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ self ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inIotaExpression: aViennaNode do: aBlock [
	^ self
		freeOccurrencesOf: aString
		inSingleQuantifierExpression: aViennaNode
		do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLambdaExpression: aViennaNode do: aBlock [

	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	aViennaNode first do: [ :bind |
		bind first
			allDescendantsSuchThat: [ :n |
			n isViennaPatternIdentifierNode: aString ]
			do: [ :n | ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLet: aViennaNode do: aBlock [

	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	aViennaNode localDefinitionsDo: [ :def |
		def isViennaValueDefinitionNode ifTrue: [
			def pattern
				allDescendantsSuchThat: [ :n |
				n isViennaPatternIdentifierNode: aString ]
				do: [ :n | ^ self ] ].
		(def isFunctionDefinition and: [ def identifier = aString ])
			ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLetBe: aViennaNode do: aBlock [

	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	aViennaNode first first
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ self ].
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLetBeExpression: aViennaNode do: aBlock [
	^ self freeOccurrencesOf: aString inLetBe: aViennaNode do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLetBeStatement: aViennaNode do: aBlock [
	^ self freeOccurrencesOf: aString inLetBe: aViennaNode do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLetExpression: aViennaNode do: aBlock [
	^ self freeOccurrencesOf: aString inLet: aViennaNode do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLetStatement: aViennaNode do: aBlock [
	^ self freeOccurrencesOf: aString inLet: aViennaNode do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLocalName: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ]
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inMapComprehension: aViennaNode do: aBlock [

	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock.
	aViennaNode third do: [ :multiBind |
		multiBind first do: [ :pattern |
			pattern
				allDescendantsSuchThat: [ :n |
				n isViennaPatternIdentifierNode: aString ]
				do: [ :n | ^ self ] ] ].
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode fourth do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inOldName: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ]
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inOperationImport: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inSequenceComprehension: aViennaNode do: aBlock [

	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	aViennaNode second first
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ self ].
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inSequenceForLoop: aViennaNode do: aBlock [

	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	aViennaNode first
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ self ].
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inSetComprehension: aViennaNode do: aBlock [

	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	aViennaNode second do: [ :multiBind |
		multiBind first do: [ :pattern |
			pattern
				allDescendantsSuchThat: [ :n |
				n isViennaPatternIdentifierNode: aString ]
				do: [ :n | ^ self ] ] ].
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inSetForLoop: aViennaNode do: aBlock [

	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	aViennaNode first
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ self ].
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inSingleQuantifierExpression: aViennaNode do: aBlock [

	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	aViennaNode first first
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ self ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inTypeImport: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inValueImport: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> hasFreeOccurrencesOf: aString in: aViennaNode [
	self
		freeOccurrencesOf: aString
		in: aViennaNode
		do: [ :node | ^ true ].
	^ false
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> hasLocalBindingOf: aString in: aViennaNode [
	self bindingOf: aString in: aViennaNode do: [ :n | ^ true ].
	^ false
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeBy: aViennaNode do: aBlock [
	| selector |
	aViennaNode isViennaNode
		ifFalse: [ ^ self ].
	selector := ('localScopeBy' , aViennaNode label , ':do:') asSymbol.
	(self respondsTo: selector)
		ifTrue: [ self perform: selector with: aViennaNode with: aBlock ]
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByBlockStatement: aViennaNode do: aBlock [
	aBlock value: aViennaNode
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByCasesExpressionAlternative: aViennaNode do: aBlock [
	aBlock value: aViennaNode second
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByCasesStatementAlternative: aViennaNode do: aBlock [
	aBlock value: aViennaNode second
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByDefExpression: aViennaNode do: aBlock [
	aBlock value: aViennaNode
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByDefStatement: aViennaNode do: aBlock [
	aBlock value: aViennaNode
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByExists1Expression: aViennaNode do: aBlock [
	aBlock value: aViennaNode second
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByExistsExpression: aViennaNode do: aBlock [
	aBlock value: aViennaNode second
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByExplicitFunctionDefinition: aViennaNode do: aBlock [

	aBlock value: aViennaNode expression.
	aBlock value: aViennaNode pre.
	aBlock value: aViennaNode post
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByExplicitOperationDefinition: aViennaNode do: aBlock [

	aBlock value: aViennaNode statement.
	aBlock value: aViennaNode pre.
	aBlock value: aViennaNode post
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByForallExpression: aViennaNode do: aBlock [
	aBlock value: aViennaNode second
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByImplicitFunctionDefinition: aViennaNode do: aBlock [

	aBlock value: aViennaNode pre.
	aBlock value: aViennaNode post
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByImplicitOperationDefinition: aViennaNode do: aBlock [
	aBlock value: aViennaNode fourth second.
	aBlock value: aViennaNode fourth third.
	aBlock value: aViennaNode fourth fourth
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByIndexForLoopDefinition: aViennaNode do: aBlock [

	aBlock value: aViennaNode statement
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByInvariantInitialFunction: aViennaNode do: aBlock [
	aBlock value: aViennaNode second
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByIotaExpression: aViennaNode do: aBlock [
	aBlock value: aViennaNode second
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByLambdaExpression: aViennaNode do: aBlock [
	aBlock value: aViennaNode second
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByLetBeExpression: aViennaNode do: aBlock [
	aBlock value: aViennaNode
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByLetBeStatement: aViennaNode do: aBlock [
	aBlock value: aViennaNode
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByLetExpression: aViennaNode do: aBlock [
	aBlock value: aViennaNode
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByLetStatement: aViennaNode do: aBlock [
	aBlock value: aViennaNode
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByMapComprehension: aViennaNode do: aBlock [
	aBlock value: aViennaNode first.
	aBlock value: aViennaNode second.
	aBlock value: aViennaNode fourth
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeBySequenceComprehension: aViennaNode do: aBlock [
	aBlock value: aViennaNode first.
	aBlock value: aViennaNode third
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeBySequenceForLoop: aViennaNode do: aBlock [
	aBlock value: aViennaNode third
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeBySetComprehension: aViennaNode do: aBlock [
	aBlock value: aViennaNode first.
	aBlock value: aViennaNode third
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeBySetForLoop: aViennaNode do: aBlock [
	aBlock value: aViennaNode third
]

{ #category : #'visiting-pattern matching' }
ViennaRefactoring >> match: aViennaNode with: anotherViennaNode bindings: aDictionary [

	aViennaNode isViennaLocalNameNode ifTrue: [
		^ aDictionary
			  at: aViennaNode identifier
			  ifPresent: [ :node |
				  node
					  ifNil: [
						  aDictionary
							  at: aViennaNode identifier
							  put: anotherViennaNode copyFragment.
						  true ]
					  ifNotNil: [ anotherViennaNode = node ] ]
			  ifAbsent: [ aViennaNode = anotherViennaNode ] ].
	aViennaNode = anotherViennaNode ifTrue: [
		aDictionary keys do: [ :string |
			(aDictionary at: string) ifNil: [
				aDictionary
					at: string
					put: (ViennaLocalNameNode identifier: string) ] ].
		^ true ].
	aViennaNode class = anotherViennaNode class ifFalse: [ ^ false ].
	aViennaNode size = anotherViennaNode size ifFalse: [ ^ false ].
	^ (1 to: aViennaNode size) allSatisfy: [ :index |
		  | node1 node2 |
		  node1 := aViennaNode at: index.
		  node2 := anotherViennaNode at: index.
		  node1 isViennaNode
			  ifTrue: [
				  node2 isViennaNode and: [
					  self match: node1 with: node2 bindings: aDictionary ] ]
			  ifFalse: [ node1 = node2 ] ]
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> migrate: aViennaNode into: moduleNode [

	aViennaNode module == moduleNode ifTrue: [ ^ aViennaNode ].
	aViennaNode isViennaLocalNameNode ifTrue: [
		aViennaNode asGlobalName ifNotNil: [ :globalName |
			self ensureImport: globalName resolve in: moduleNode.
			^ self
				  replaceNode: aViennaNode
				  with: (self nameForGlobalName: globalName in: moduleNode) ] ].
	aViennaNode isViennaGlobalNameNode ifTrue: [
		self ensureImport: aViennaNode resolve in: moduleNode.
		^ self
			  replaceNode: aViennaNode
			  with: (self nameForGlobalName: aViennaNode in: moduleNode) ].
	aViennaNode do: [ :node |
		node isViennaNode ifTrue: [ self migrate: node into: moduleNode ] ].
	^ aViennaNode
]

{ #category : #accessing }
ViennaRefactoring >> name [
	^ self subclassResponsibility
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> nameForGlobalName: globalNameNode in: moduleNode [

	globalNameNode moduleIdentifier = moduleNode identifier ifTrue: [
		^ (ViennaLocalNameNode identifier: globalNameNode identifier)
			  parent: globalNameNode parent;
			  yourself ].
	moduleNode
		importsFrom: globalNameNode moduleIdentifier
		do: [ :importModuleSignature |
			importModuleSignature isViennaImportModuleSignatureAllNode ifTrue: [
				^ globalNameNode copyFragment ].
			importModuleSignature do: [ :importSignature |
				importSignature do: [ :import |
					import identifier = globalNameNode identifier ifTrue: [
						^ import last
							  ifNotNil: [ :name |
								  name copyFragment
									  parent: globalNameNode parent;
									  yourself ]
							  ifNil: [ globalNameNode copyFragment ] ] ] ] ].
	^ nil
]

{ #category : #'visiting-labels' }
ViennaRefactoring >> patternIdentifiersWith: aString in: aViennaNode do: aBlock [

	(aViennaNode isViennaPatternIdentifierNode: aString) ifTrue: [
		aBlock cull: aViennaNode ].
	aViennaNode
		allDescendantsSuchThat: [ :node |
		node isViennaPatternIdentifierNode: aString ]
		do: [ :node | aBlock cull: node ]
]

{ #category : #signaling }
ViennaRefactoring >> refactoringError: aViennaNode [
	^ (ViennaRefactoringError refactoring: self node: aViennaNode) signal
]

{ #category : #'visiting-definitions' }
ViennaRefactoring >> removeFunctionDefinition: aViennaNode [

	| section |
	section := aViennaNode parent.
	section remove: aViennaNode.
	section ifEmpty: [ section parent remove: section ]
]

{ #category : #'visiting-definitions' }
ViennaRefactoring >> removeOperationDefinition: aViennaNode [

	| section |
	section := aViennaNode parent.
	section remove: aViennaNode.
	section ifEmpty: [ section parent remove: section ]
]

{ #category : #'visiting-definitions' }
ViennaRefactoring >> removeTypeDefinition: aViennaNode [

	| section |
	section := aViennaNode parent.
	section remove: aViennaNode.
	section ifEmpty: [ section parent remove: section ]
]

{ #category : #'visiting-definitions' }
ViennaRefactoring >> removeValueDefinition: aViennaNode [

	| section |
	section := aViennaNode parent.
	section remove: aViennaNode.
	section ifEmpty: [ section parent remove: section ]
]

{ #category : #'visiting-manipulations' }
ViennaRefactoring >> replaceNode: aViennaNode with: anotherViennaNode [
	aViennaNode ~~ anotherViennaNode
		ifTrue: [ | parent |
			parent := aViennaNode parent.
			1 to: parent size do: [ :index | 
				(parent at: index) == aViennaNode
					ifTrue: [ parent at: index put: anotherViennaNode ] ] ].
	^ anotherViennaNode
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> retractExport: aViennaNode [

	aViennaNode isViennaGlobalNameNode ifTrue: [ ^ aViennaNode ].
	(aViennaNode isViennaLocalNameNode and: [
		 aViennaNode resolve module == aViennaNode module ]) ifTrue: [
		^ self retractExport: aViennaNode resolve ].
	aViennaNode asExportSignature ifNotNil: [ :signature |
		self retractExportSignature: signature in: aViennaNode module ].
	^ nil
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> retractExportSignature: aViennaNode in: moduleNode [

	aViennaNode exportedIdentifiers do: [ :identifier |
		moduleNode exportDefinition exportModuleSignature removeIdentifier:
			identifier ]
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> retractImport: aViennaNode in: moduleNode [

	aViennaNode isViennaGlobalNameNode ifTrue: [ ^ aViennaNode ].
	(aViennaNode isViennaLocalNameNode and: [
		 aViennaNode resolve module == aViennaNode module ]) ifTrue: [
		^ self retractImport: aViennaNode resolve in: moduleNode ].
	(aViennaNode asImportDefinitionIn: moduleNode) ifNotNil: [ :signature |
		self retractImportDefinition: signature in: moduleNode ].
	^ nil
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> retractImportDefinition: aViennaNode in: moduleNode [

	moduleNode
		importsFrom: aViennaNode first
		do: [ :importModuleSignature |
			importModuleSignature isViennaImportModuleSignatureNode ifTrue: [
				importModuleSignature asArray do: [ :importSignature |
					importSignature asArray do: [ :import |
						(aViennaNode second anySatisfy: [ :sig |
							 sig anySatisfy: [ :imp | imp name = import name ] ]) ifTrue: [
							importSignature remove: import ] ].
					importSignature ifEmpty: [
						importModuleSignature remove: importSignature ] ].
				importModuleSignature ifEmpty: [
					importModuleSignature parent parent remove:
						importModuleSignature parent.
					importModuleSignature parent parent ifEmpty: [
						importModuleSignature parent parent parent at: 1 put: nil ] ] ] ]
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> scopeOf: aViennaNode [

	aViennaNode scopesDo: [ :node | ^ node ].
	^ nil
]

{ #category : #accessing }
ViennaRefactoring >> shortDescription: aString [
	^ aString size > 50
		ifTrue: [ (aString first: 50) , '...' ]
		ifFalse: [ aString ]
]

{ #category : #accessing }
ViennaRefactoring >> sortingOrder [
	^ self subclassResponsibility
]
