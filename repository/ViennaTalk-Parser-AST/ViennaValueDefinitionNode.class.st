Class {
	#name : #ViennaValueDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaValueDefinitionNode class >> pattern: aViennaPatternNode type: aViennaTypeNode expression: aViennaExpressionNode [

	^ (self new: 3)
		  pattern: aViennaPatternNode;
		  type: aViennaTypeNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaValueDefinitionNode >> asAccessDefinition [

	^ ViennaAccessValueDefinitionNode
		  access: ViennaAccessNode empty
		  valueDefinition: self
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

	^ self at: 3
]

{ #category : #accessing }
ViennaValueDefinitionNode >> expression: aViennaExpressionNode [

	self at: 3 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaValueDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| pattern type expression |
	pattern := aViennaAbstractFormatter format: self pattern.
	type := self type
		        ifNil: [ '' ]
		        ifNotNil: [ :node |
		        ' : ' , (aViennaAbstractFormatter format: node) ].
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter
		  indentString: pattern , type , ' ='
		  insertCrIfNeeded: expression
]

{ #category : #private }
ViennaValueDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self pattern freeIdentifiersExcept: aSet do: aBlock.
	self type freeIdentifiersExcept: aSet do: aBlock.
	self expression freeIdentifiersExcept: aSet do: aBlock
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

{ #category : #accessing }
ViennaValueDefinitionNode >> pattern [

	^ self at: 1
]

{ #category : #accessing }
ViennaValueDefinitionNode >> pattern: aViennaPatternNode [

	self at: 1 put: aViennaPatternNode
]

{ #category : #'accessing-definitions' }
ViennaValueDefinitionNode >> resolve [

	^ self
]

{ #category : #accessing }
ViennaValueDefinitionNode >> type [

	^ self at: 2
]

{ #category : #accessing }
ViennaValueDefinitionNode >> type: aViennaTypeNode [

	self at: 2 put: aViennaTypeNode
]
