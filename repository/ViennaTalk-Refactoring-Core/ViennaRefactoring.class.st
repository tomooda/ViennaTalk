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
	| sectionLabel moduleBody section |
	sectionLabel := self definitionsLabelFor: aViennaNode.
	moduleBody := moduleNode module third.
	section := (moduleBody
		detect: [ :definitionBlock | 
			definitionBlock isViennaNode
				and: [ definitionBlock first isViennaNode
						and: [ definitionBlock first label = sectionLabel ] ] ]
		ifNone: [ | definitionBlock |
			definitionBlock := ViennaNode
				label: 'DefinitionBlock'
				with: (ViennaNode label: sectionLabel).
			moduleBody add: definitionBlock.
			definitionBlock ]) ifNotNil: #first.
	section add: aViennaNode asAccessDefinition
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
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inError: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inExplicitFunctionDefinition: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inExplicitOperationDefinition: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inImplicitFunctionDefinition: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inImplicitOperationDefinition: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inIndexForLoop: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inPatternIdentifier: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inRecordTypeDefinition: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inStateDefinition: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode second
		do: [ :field | 
			field first = aString
				ifTrue: [ aBlock value: field ] ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inTypeDefinition: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
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

{ #category : #'visiting-definitions' }
ViennaRefactoring >> definitionsLabelFor: aViennaNode [
	(#('TypeDefinition' 'RecordTypeDefinition')
		includes: aViennaNode label)
		ifTrue: [ ^ 'TypeDefinitions' ].
	(#('ValueDefinition') includes: aViennaNode label)
		ifTrue: [ ^ 'ValueDefinitions' ].
	(#('ExplicitFunctionDefinition' 'ImplicitFunctionDefinition')
		includes: aViennaNode label)
		ifTrue: [ ^ 'FunctionDefinitions' ].
	(#('ExplicitOperationDefinition' 'ImplicitOperationDefinition')
		includes: aViennaNode label)
		ifTrue: [ ^ 'OperationDefinitions' ].
	^ nil
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> directScopeNodeLabels [
	^ #('IndexForLoop') asSet
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> enclosingScopeNodeLabels [
	^ #('Document' 'Module' 'ExplicitFunctionDefinition' 'ImplicitFunctionDefinition' 'ExplicitOperationDefinition' 'ImplicitOperationDefinition' 'CasesExpressionAlternative' 'CasesStatementAlternative' 'LetExpression' 'LetStatement' 'LetBeExpression' 'LetBeStatement' 'SequenceComprehension' 'SetComprehension' 'MapComprehension' 'ForallExpression' 'ExistsExpression' 'Exists1Expression' 'IotaExpression' 'LambdaExpression' 'InvariantInitialFunction' 'SequenceForLoop' 'SetForLoop' 'BlockStatement')
		asSet
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> ensureExport: aViennaNode [
	aViennaNode label = 'GlobalName'
		ifTrue: [ ^ aViennaNode ].
	(aViennaNode label = 'LocalName'
		and: [ aViennaNode resolve module == aViennaNode module ])
		ifTrue: [ ^ self ensureExport: aViennaNode resolve ].
	aViennaNode asExportSignature
		ifNotNil:
			[ :signature | self ensureExportSignature: signature in: aViennaNode module ].
	^ nil
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> ensureExportSignature: aViennaNode in: moduleNode [
	| exportModuleSignature |
	exportModuleSignature := moduleNode exports first.
	exportModuleSignature label = 'ExportModuleSignatureAll'
		ifTrue: [ ^ exportModuleSignature ].
	exportModuleSignature
		reverseDo: [ :exportSignature | 
			exportSignature label = aViennaNode label
				ifTrue: [ exportSignature add: aViennaNode first.
					^ exportSignature ] ].
	exportModuleSignature add: aViennaNode.
	^ aViennaNode
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> ensureImport: aViennaNode in: moduleNode [
	| importModuleSignature |
	aViennaNode module == moduleNode
		ifTrue: [ ^ self ].
	importModuleSignature := (self
		ensureImportDefinitionFrom: aViennaNode module name
		in: moduleNode) second.
	importModuleSignature label = 'ImportModuleSignatureAll'
		ifTrue: [ ^ self ].
	(aViennaNode asImportDefinitionIn: moduleNode)
		ifNotNil: [ :srcImportDefinition | 
			srcImportDefinition second
				do: [ :srcImportSignature | 
					| signatures |
					signatures := srcImportSignature asArray asOrderedCollection.
					srcImportSignature asArray
						do: [ :srcImport | 
							(importModuleSignature
								anySatisfy: [ :importSignature | 
									importSignature label = srcImportSignature label
										and: [ importSignature
												anySatisfy: [ :import | import name = srcImport name ] ] ])
								ifTrue: [ signatures remove: srcImport ifAbsent: [  ] ] ].
					signatures
						ifNotEmpty: [ (self
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
	moduleNode
		importsFrom: srcName
		do: [ :importModuleSignature | 
			importModuleSignature label = 'ImportModuleSignatureAll'
				ifTrue: [ ^ importModuleSignature parent ].
			last := importModuleSignature parent ].
	last
		ifNil: [ last := ViennaNode
				label: 'ImportDefinition'
				with: srcName
				with: (ViennaNode label: 'ImportModuleSignature').
			moduleNode ensureImports add: last ].
	^ last
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> ensureImportSignatureFor: importSignatureNode in: importModuleSignatureNode [
	^ importModuleSignatureNode asArray
		detect:
			[ :importSignature | importSignature label = importSignatureNode label ]
		ifNone: [ | importSignature |
			importSignature := ViennaNode label: importSignatureNode label.
			importModuleSignatureNode add: importSignature.
			importSignature ]
]

{ #category : #operations }
ViennaRefactoring >> execute [
	^ self subclassResponsibility
]

{ #category : #'visiting-pattern matching' }
ViennaRefactoring >> expressionFromPattern: aViennaNode bindings: aDictionary [
	aViennaNode label = 'PatternIdentifier'
		ifTrue: [ ^ aDictionary
				at: aViennaNode name
				ifPresent: [ :node | node copyFragment ]
				ifAbsent: [ ViennaNode label: 'LocalName' with: aViennaNode name ] ].
	aViennaNode label = 'MapEnumerationPattern'
		ifTrue: [ ^ ViennaNode
				label: 'MapEnumeration'
				withAll:
					(aViennaNode asArray
						collect: [ :node | 
							node isViennaNode
								ifTrue: [ self expressionFromPattern: node bindings: aDictionary ]
								ifFalse: [ node ] ]) ].
	aViennaNode label = 'MapMunionPattern'
		ifTrue: [ ^ ViennaNode
				label: 'MapMerge'
				withAll:
					(aViennaNode asArray
						collect: [ :node | 
							node isViennaNode
								ifTrue: [ self expressionFromPattern: node bindings: aDictionary ]
								ifFalse: [ node ] ]) ].
	aViennaNode label = 'MapletPattern'
		ifTrue: [ ^ ViennaNode
				label: 'Maplet'
				withAll:
					(aViennaNode asArray
						collect: [ :node | 
							node isViennaNode
								ifTrue: [ self expressionFromPattern: node bindings: aDictionary ]
								ifFalse: [ node ] ]) ].
	aViennaNode label = 'MatchValue'
		ifTrue: [ ^ aViennaNode first ].
	aViennaNode label = 'RecordPattern'
		ifTrue: [ ^ ViennaNode
				label: 'RecordConstructor'
				withAll:
					(aViennaNode asArray
						collect: [ :node | 
							node isViennaNode
								ifTrue: [ self expressionFromPattern: node bindings: aDictionary ]
								ifFalse: [ node ] ]) ].
	aViennaNode label = 'SeqConcPattern'
		ifTrue: [ ^ ViennaNode
				label: 'SequenceConcatenate'
				withAll:
					(aViennaNode asArray
						collect: [ :node | 
							node isViennaNode
								ifTrue: [ self expressionFromPattern: node bindings: aDictionary ]
								ifFalse: [ node ] ]) ].
	aViennaNode label = 'SeqEnumPattern'
		ifTrue: [ ^ ViennaNode
				label: 'SequenceEnumeration'
				withAll:
					(aViennaNode asArray
						collect: [ :node | 
							node isViennaNode
								ifTrue: [ self expressionFromPattern: node bindings: aDictionary ]
								ifFalse: [ node ] ]) ].
	aViennaNode label = 'SetEnumPattern'
		ifTrue: [ ^ ViennaNode
				label: 'SetEnumeration'
				withAll:
					(aViennaNode asArray
						collect: [ :node | 
							node isViennaNode
								ifTrue: [ self expressionFromPattern: node bindings: aDictionary ]
								ifFalse: [ node ] ]) ].
	aViennaNode label = 'SetUnionPattern'
		ifTrue: [ ^ ViennaNode
				label: 'SetUnion'
				withAll:
					(aViennaNode asArray
						collect: [ :node | 
							node isViennaNode
								ifTrue: [ self expressionFromPattern: node bindings: aDictionary ]
								ifFalse: [ node ] ]) ].
	aViennaNode label = 'TuplePattern'
		ifTrue: [ ^ ViennaNode
				label: 'TupleConstructor'
				withAll:
					(aViennaNode asArray
						collect: [ :node | 
							node isViennaNode
								ifTrue: [ self expressionFromPattern: node bindings: aDictionary ]
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
	aViennaNode first label = 'DclStatement'
		ifTrue: [ self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
			aViennaNode first
				do: [ :dclDef | 
					dclDef first = aString
						ifTrue: [ ^ self ] ].
			2 to: aViennaNode size do:
				[ :index | self freeOccurrencesOf: aString in: (aViennaNode at: index) do: aBlock ] ].
	aViennaNode
		do: [ :node | self freeOccurrencesOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inCasesAlternative: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	aViennaNode first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
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
	aViennaNode first
		do: [ :equalDefinition | 
			self freeOccurrencesOf: aString in: equalDefinition do: aBlock.
			equalDefinition first
				allDescendantsDo: [ :n | 
					(n label = 'PatternIdentifier' and: [ n first = aString ])
						ifTrue: [ ^ self ] ] ].
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
	aViennaNode second
		do: [ :n | 
			(n label = 'TypeVariableIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode fourth do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode fifth do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode ninth do: aBlock.
	aViennaNode fifth
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode sixth do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode seventh do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode eighth do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inExplicitOperationDefinition: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode fourth do: aBlock.
	aViennaNode fifth
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode fifth do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode sixth do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode seventh do: aBlock
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
	aViennaNode first
		do: [ :multiBind | 
			multiBind first
				do: [ :pattern | 
					pattern
						allDescendantsDo: [ :n | 
							(n label = 'PatternIdentifier' and: [ n first = aString ])
								ifTrue: [ ^ self ] ] ] ].
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
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode fourth do: aBlock.
	aViennaNode third first
		ifNotEmpty: [ :patternTypePairList | 
			1 to: patternTypePairList size by: 2 do: [ :index | 
				(patternTypePairList at: index)
					allDescendantsDo: [ :n | 
						(n label = 'PatternIdentifier' and: [ n first = aString ])
							ifTrue: [ ^ self ] ] ] ].
	self freeOccurrencesOf: aString in: aViennaNode fifth do: aBlock.
	aViennaNode fourth
		ifNotEmpty: [ :identifierTypePairList | 
			1 to: identifierTypePairList size by: 2 do: [ :index | 
				(identifierTypePairList at: index) = aString
					ifTrue: [ ^ self ] ] ].
	self freeOccurrencesOf: aString in: aViennaNode sixth do: aBlock
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
	aViennaNode second first
		ifNotEmpty: [ :patternTypePairList | 
			1 to: patternTypePairList size by: 2 do: [ :index | 
				(patternTypePairList at: index)
					allDescendantsDo: [ :n | 
						(n label = 'PatternIdentifier' and: [ n first = aString ])
							ifTrue: [ ^ self ] ] ] ].
	self
		freeOccurrencesOf: aString
		in: aViennaNode fourth second
		do: aBlock.
	aViennaNode fourth
		ifNotEmpty: [ :identifierTypePairList | 
			1 to: identifierTypePairList size by: 2 do: [ :index | 
				(identifierTypePairList at: index) = aString
					ifTrue: [ ^ self ] ] ].
	self
		freeOccurrencesOf: aString
		in: aViennaNode fourth third
		do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inIndexForLoop: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode fourth do: aBlock.
	aViennaNode first = aString
		ifTrue: [ ^ self ].
	self freeOccurrencesOf: aString in: aViennaNode fifth do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inInvariantInitialFunction: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	aViennaNode first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
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
	aViennaNode first
		do: [ :bind | 
			bind first
				allDescendantsDo: [ :node | 
					(node label = 'PatternIdentifier' and: [ node first = aString ])
						ifTrue: [ ^ self ] ] ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLet: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	aViennaNode first
		do: [ :localDef | 
			| def |
			def := localDef first.
			def label = 'ValueDefinition'
				ifTrue: [ def first
						allDescendantsDo: [ :n | 
							(n label = 'PatternIdentifier' and: [ n first = aString ])
								ifTrue: [ ^ self ] ] ].
			(def label = 'FunctionDefinition'
				and: [ def first first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLetBe: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	aViennaNode first first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
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
	aViennaNode third
		do: [ :multiBind | 
			multiBind first
				do: [ :pattern | 
					pattern
						allDescendantsDo: [ :n | 
							(n label = 'PatternIdentifier' and: [ n first = aString ])
								ifTrue: [ ^ self ] ] ] ].
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
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inSequenceForLoop: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	aViennaNode first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inSetComprehension: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	aViennaNode second
		do: [ :multiBind | 
			multiBind first
				do: [ :pattern | 
					pattern
						allDescendantsDo: [ :n | 
							(n label = 'PatternIdentifier' and: [ n first = aString ])
								ifTrue: [ ^ self ] ] ] ].
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inSetForLoop: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	aViennaNode first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inSingleQuantifierExpression: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	aViennaNode first first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
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
	aBlock value: aViennaNode sixth.
	aBlock value: aViennaNode seventh.
	aBlock value: aViennaNode eighth
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByExplicitOperationDefinition: aViennaNode do: aBlock [
	aBlock value: aViennaNode fifth first.
	aBlock value: aViennaNode sixth.
	aBlock value: aViennaNode seventh
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByForallExpression: aViennaNode do: aBlock [
	aBlock value: aViennaNode second
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByImplicitFunctionDefinition: aViennaNode do: aBlock [
	aBlock value: aViennaNode fifth.
	aBlock value: aViennaNode sixth
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByImplicitOperationDefinition: aViennaNode do: aBlock [
	aBlock value: aViennaNode fourth second.
	aBlock value: aViennaNode fourth third.
	aBlock value: aViennaNode fourth fourth
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByIndexForLoopDefinition: aViennaNode do: aBlock [
	aBlock value: aViennaNode fifth
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
	(aViennaNode sameAs: anotherViennaNode)
		ifTrue: [ ^ true ].
	aViennaNode label = 'LocalName'
		ifTrue: [ ^ aDictionary
				at: aViennaNode name
				ifPresent: [ :node | 
					node
						ifNil:
							[ aDictionary at: aViennaNode name put: anotherViennaNode copyFragment.
							true ]
						ifNotNil: [ anotherViennaNode sameAs: node ] ]
				ifAbsent: [ false ] ].
	aViennaNode label = anotherViennaNode label
		ifFalse: [ ^ false ].
	aViennaNode size = anotherViennaNode size
		ifFalse: [ ^ false ].
	^ (1 to: aViennaNode size)
		allSatisfy: [ :index | 
			| node1 node2 |
			node1 := aViennaNode at: index.
			node2 := anotherViennaNode at: index.
			node1 isViennaNode
				ifTrue: [ node2 isViennaNode
						and: [ self match: node1 with: node2 bindings: aDictionary ] ]
				ifFalse: [ node1 = node2 ] ]
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> migrate: aViennaNode into: moduleNode [
	aViennaNode module == moduleNode
		ifTrue: [ ^ aViennaNode ].
	aViennaNode label = 'LocalName'
		ifTrue: [ aViennaNode asGlobalName
				ifNotNil: [ :globalName | 
					self ensureImport: globalName resolve in: moduleNode.
					^ self
						replaceNode: aViennaNode
						with: (self nameForGlobalName: globalName in: moduleNode) ] ].
	aViennaNode label = 'GlobalName'
		ifTrue: [ self ensureImport: aViennaNode resolve in: moduleNode.
			^ self
				replaceNode: aViennaNode
				with: (self nameForGlobalName: aViennaNode in: moduleNode) ].
	aViennaNode
		do: [ :node | 
			node isViennaNode
				ifTrue: [ self migrate: node into: moduleNode ] ].
	^ aViennaNode
]

{ #category : #accessing }
ViennaRefactoring >> name [
	^ self subclassResponsibility
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> nameForGlobalName: globalNameNode in: moduleNode [
	globalNameNode first = moduleNode name
		ifTrue: [ ^ (ViennaNode label: 'LocalName' with: globalNameNode second)
				parent: globalNameNode parent;
				yourself ].
	moduleNode
		importsFrom: globalNameNode first
		do: [ :importModuleSignature | 
			importModuleSignature label = 'ImportModuleSignatureAll'
				ifTrue: [ ^ globalNameNode copyFragment ].
			importModuleSignature
				do: [ :importSignature | 
					importSignature
						do: [ :import | 
							import name = globalNameNode second
								ifTrue: [ ^ import last
										ifNotNil: [ :name | 
											name copyFragment
												parent: globalNameNode parent;
												yourself ]
										ifNil: [ ^ globalNameNode copyFragment ] ] ] ] ].
	^ nil
]

{ #category : #'visiting-labels' }
ViennaRefactoring >> patternIdentifiersWith: aString in: aViennaNode do: aBlock [
	(aViennaNode label = 'PatternIdentifier'
		and: [ aViennaNode first = aString ])
		ifTrue: [ aBlock cull: aViennaNode ].
	aViennaNode
		allDescendantsDo: [ :node | 
			(node label = 'PatternIdentifier' and: [ node first = aString ])
				ifTrue: [ aBlock cull: node ] ]
]

{ #category : #signaling }
ViennaRefactoring >> refactoringError: aViennaNode [
	^ (ViennaRefactoringError refactoring: self node: aViennaNode) signal
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
	aViennaNode label = 'GlobalName'
		ifTrue: [ ^ aViennaNode ].
	(aViennaNode label = 'LocalName'
		and: [ aViennaNode resolve module == aViennaNode module ])
		ifTrue: [ ^ self retractExport: aViennaNode resolve ].
	aViennaNode asExportSignature
		ifNotNil:
			[ :signature | self retractExportSignature: signature in: aViennaNode module ].
	^ nil
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> retractExportSignature: aViennaNode in: moduleNode [
	| exportModuleSignature names |
	exportModuleSignature := moduleNode exports first.
	exportModuleSignature label = 'ExportModuleSignatureAll'
		ifTrue: [ ^ exportModuleSignature ].
	names := OrderedCollection new.
	aViennaNode
		do: [ :export | 
			export label = 'TypeNameExport'
				ifTrue: [ names add: export first first ].
			export label = 'TypeStructExport'
				ifTrue: [ names add: export first first ].
			export label = 'ValueExport'
				ifTrue: [ export first do: [ :localName | names add: localName first ] ].
			export label = 'FunctionExport'
				ifTrue: [ export first do: [ :localName | names add: localName first ] ].
			export label = 'OperationExport'
				ifTrue: [ export first do: [ :localName | names add: localName first ] ] ].
	names
		ifNotEmpty: [ exportModuleSignature asArray
				do: [ :exportSignature | 
					exportSignature asArray
						do: [ :export | 
							(#('TypeNameExport' 'TypeStructExport') includes: export label)
								ifTrue: [ (names includes: export first first)
										ifTrue: [ exportSignature remove: export ] ]
								ifFalse: [ export first asArray
										do: [ :localName | 
											(names includes: localName first)
												ifTrue: [ export first remove: localName ] ].
									export first ifEmpty: [ exportSignature remove: export ] ] ] ].
			exportModuleSignature
				ifEmpty: [ self
						replaceNode: exportModuleSignature
						with: (ViennaNode label: 'ExportModuleSignatureAll') ] ]
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> retractImport: aViennaNode in: moduleNode [
	aViennaNode label = 'GlobalName'
		ifTrue: [ ^ aViennaNode ].
	(aViennaNode label = 'LocalName'
		and: [ aViennaNode resolve module == aViennaNode module ])
		ifTrue: [ ^ self retractImport: aViennaNode resolve in: moduleNode ].
	(aViennaNode asImportDefinitionIn: moduleNode)
		ifNotNil:
			[ :signature | self retractImportDefinition: signature in: moduleNode ].
	^ nil
]

{ #category : #'visiting-interface' }
ViennaRefactoring >> retractImportDefinition: aViennaNode in: moduleNode [
	moduleNode
		importsFrom: aViennaNode first
		do: [ :importModuleSignature | 
			importModuleSignature label = 'ImportModuleSignature'
				ifTrue: [ importModuleSignature asArray
						do: [ :importSignature | 
							importSignature asArray
								do: [ :import | 
									(aViennaNode second
										anySatisfy: [ :sig | sig anySatisfy: [ :imp | imp name = import name ] ])
										ifTrue: [ importSignature remove: import ] ].
							importSignature
								ifEmpty: [ importModuleSignature remove: importSignature ] ].
					importModuleSignature
						ifEmpty: [ importModuleSignature parent parent
								remove: importModuleSignature parent.
							importModuleSignature parent parent
								ifEmpty: [ importModuleSignature parent parent parent at: 1 put: nil ] ] ] ]
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> scopeOf: aViennaNode [
	| scopingNodeLabels node |
	scopingNodeLabels := self enclosingScopeNodeLabels.
	(self directScopeNodeLabels includes: aViennaNode label)
		ifTrue: [ ^ aViennaNode ].
	node := aViennaNode parent ifNil: [ ^ aViennaNode ].
	[ scopingNodeLabels includes: node label ]
		whileFalse: [ (node := node parent) ifNil: [ ^ node ] ].
	^ node
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
