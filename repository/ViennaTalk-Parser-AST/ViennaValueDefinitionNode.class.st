Class {
	#name : #ViennaValueDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaValueDefinitionNode class >> access: aViennaAccessNode pattern: aViennaPatternNode type: aViennaTypeNode expression: aViennaExpressionNode [

	^ (self new: 4)
		  access: aViennaAccessNode;
		  pattern: aViennaPatternNode;
		  type: aViennaTypeNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #'instance creation' }
ViennaValueDefinitionNode class >> pattern: aViennaPatternNode type: aViennaTypeNode expression: aViennaExpressionNode [

	^ self
		  access: ViennaAccessNode empty
		  pattern: aViennaPatternNode
		  type: aViennaTypeNode
		  expression: aViennaExpressionNode
]

{ #category : #accessing }
ViennaValueDefinitionNode >> access [

	^ self at: 1
]

{ #category : #accessing }
ViennaValueDefinitionNode >> access: aViennaAccessNode [

	self at: 1 put: aViennaAccessNode
]

{ #category : #'accessing-definitions' }
ViennaValueDefinitionNode >> asAccessDefinition [

	^ self
]

{ #category : #'accessing-definitions' }
ViennaValueDefinitionNode >> asExport [

	^ ViennaValueExportNode
		  nameList: (ViennaNameListNode withAll:
				   (self pattern patternIdentifiers collect: [ :node |
					    ViennaLocalNameNode identifier: node identifier ]))
		  type: (self pattern isViennaPatternIdentifierNode
				   ifTrue: [ self type ifNotNil: #copyFragment ]
				   ifFalse: [ nil ])
]

{ #category : #'accessing-definitions' }
ViennaValueDefinitionNode >> asImportDefinitionIn: moduleNode [

	^ ViennaImportDefinitionNode
		  moduleIdentifier: self module identifier
		  importModuleSignature: (ViennaImportModuleSignatureNode with:
				   (ViennaImportValuesSignatureNode withAll:
					    (self pattern patternIdentifierNames collect: [ :name |
						     ViennaValueImportNode
							     name: (ViennaLocalNameNode identifier: name)
							     type: (self pattern isViennaPatternIdentifierNode
									      ifTrue: [ self type ifNotNil: #copyFragment ]
									      ifFalse: [ nil ])
							     rename: nil ])))
]

{ #category : #private }
ViennaValueDefinitionNode >> boundIdentifiersDo: aBlock [

	self pattern boundIdentifiersDo: aBlock
]

{ #category : #accessing }
ViennaValueDefinitionNode >> expression [

	^ self at: 4
]

{ #category : #accessing }
ViennaValueDefinitionNode >> expression: aViennaExpressionNode [

	self at: 4 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaValueDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| access pattern type expression |
	access := (aViennaAbstractFormatter format: self access) trim
		          ifNotEmpty: [ :string | string , ' ' ].
	pattern := aViennaAbstractFormatter format: self pattern.
	type := self type
		        ifNil: [ '' ]
		        ifNotNil: [ :node |
		        ' : ' , (aViennaAbstractFormatter format: node) ].
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter
		  indentString: access , pattern , type , ' ='
		  insertCrIfNeeded: expression
]

{ #category : #private }
ViennaValueDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self pattern freeIdentifiersExcept: aSet do: aBlock.
	self type ifNotNil: [ :type |
		type freeIdentifiersExcept: aSet do: aBlock ].
	self expression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaValueDefinitionNode >> hasOnlyOnePatternIdentifier [

	^ self pattern uniqueBoundIdentifiers size = 1
]

{ #category : #accessing }
ViennaValueDefinitionNode >> identifier: aString [

	self hasOnlyOnePatternIdentifier ifTrue: [
		self pattern boundIdentifiersDo: [ :identifier :pattern |
			pattern identifier: aString ] ]
]

{ #category : #testing }
ViennaValueDefinitionNode >> isValueDefinition [

	^ true
]

{ #category : #testing }
ViennaValueDefinitionNode >> isViennaAccessValueDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaValueDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaValueDefinitionNode >> isViennaValueDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaValueDefinitionNode >> label [

	^ 'ValueDefinition'
]

{ #category : #'accessing-definitions' }
ViennaValueDefinitionNode >> localResolve [

	^ self
]

{ #category : #accessing }
ViennaValueDefinitionNode >> pattern [

	^ self at: 2
]

{ #category : #accessing }
ViennaValueDefinitionNode >> pattern: aViennaPatternNode [

	self at: 2 put: aViennaPatternNode
]

{ #category : #'accessing-definitions' }
ViennaValueDefinitionNode >> resolve [

	^ self
]

{ #category : #'class membership' }
ViennaValueDefinitionNode >> respondsTo: aSymbol [

	aSymbol = #identifier: ifTrue: [
		^ self hasOnlyOnePatternIdentifier ].
	^ super respondsTo: aSymbol
]

{ #category : #accessing }
ViennaValueDefinitionNode >> type [

	^ self at: 3
]

{ #category : #accessing }
ViennaValueDefinitionNode >> type: aViennaTypeNode [

	self at: 3 put: aViennaTypeNode
]
