Class {
	#name : 'ViennaValueDefinitionNode',
	#superclass : 'ViennaTopLevelDefinitionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaValueDefinitionNode class >> access: aViennaAccessNode pattern: aViennaPatternNode type: aViennaTypeNode expression: aViennaExpressionNode [

	^ (self new: 4)
		  access: aViennaAccessNode;
		  pattern: aViennaPatternNode;
		  type: aViennaTypeNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : 'instance creation' }
ViennaValueDefinitionNode class >> pattern: aViennaPatternNode type: aViennaTypeNode expression: aViennaExpressionNode [

	^ self
		  access: ViennaAccessNode empty
		  pattern: aViennaPatternNode
		  type: aViennaTypeNode
		  expression: aViennaExpressionNode
]

{ #category : 'accessing' }
ViennaValueDefinitionNode >> access [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaValueDefinitionNode >> access: aViennaAccessNode [

	self at: 1 put: aViennaAccessNode
]

{ #category : 'accessing' }
ViennaValueDefinitionNode >> addToModule: aViennaModuleNode [

	^ aViennaModuleNode module addValueDefinition: self copyFragment
]

{ #category : 'accessing-definitions' }
ViennaValueDefinitionNode >> asAccessDefinition [

	^ self
]

{ #category : 'accessing-definitions' }
ViennaValueDefinitionNode >> asExport [

	^ ViennaValueExportNode
		  nameList: (ViennaNameListNode withAll:
				   (self pattern patternIdentifiers collect: [ :node |
					    ViennaLocalNameNode identifier: node identifier ]))
		  type: (self pattern isViennaPatternIdentifierNode
				   ifTrue: [ self type ifNotNil: #copyFragment ]
				   ifFalse: [ nil ])
]

{ #category : 'accessing-definitions' }
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

{ #category : 'private' }
ViennaValueDefinitionNode >> boundIdentifiersDo: aBlock [

	self pattern boundIdentifiersDo: aBlock
]

{ #category : 'accessing' }
ViennaValueDefinitionNode >> expression [

	^ self at: 4
]

{ #category : 'accessing' }
ViennaValueDefinitionNode >> expression: aViennaExpressionNode [

	self at: 4 put: aViennaExpressionNode
]

{ #category : 'pretty printing' }
ViennaValueDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| access pattern type expression |
	access := (aViennaAbstractFormatter format: self access) trim
		          ifNotEmpty: [ :string |
			          aViennaAbstractFormatter empty ++ string
			          ++ aViennaAbstractFormatter space ].
	pattern := aViennaAbstractFormatter format: self pattern.
	type := self type
		        ifNil: [ aViennaAbstractFormatter empty ]
		        ifNotNil: [ :node |
		        ' : ' ++ (aViennaAbstractFormatter format: node) ].
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter
		  indentString: access ++ pattern ++ type ++ ' ='
		  insertCrIfNeeded: expression
]

{ #category : 'private' }
ViennaValueDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self pattern freeIdentifiersExcept: aSet do: aBlock.
	self type ifNotNil: [ :type |
		type freeIdentifiersExcept: aSet do: aBlock ].
	self expression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'testing' }
ViennaValueDefinitionNode >> hasOnlyOnePatternIdentifier [

	^ self pattern uniqueBoundIdentifiers size = 1
]

{ #category : 'accessing' }
ViennaValueDefinitionNode >> identifier [

	^ self pattern source
]

{ #category : 'accessing' }
ViennaValueDefinitionNode >> identifier: aString [

	self hasOnlyOnePatternIdentifier ifTrue: [
		self pattern boundIdentifiersDo: [ :identifier :pattern |
			pattern identifier: aString ] ]
]

{ #category : 'accessing' }
ViennaValueDefinitionNode >> identifiers [

	^ Array streamContents: [ :stream |
		  self pattern
			  allDescendantsSuchThat: #isViennaPatternIdentifierNode
			  do: [ :node | stream nextPut: node identifier ] ]
]

{ #category : 'testing' }
ViennaValueDefinitionNode >> isValueDefinition [

	^ true
]

{ #category : 'testing' }
ViennaValueDefinitionNode >> isViennaAccessValueDefinitionNode [

	^ true
]

{ #category : 'testing' }
ViennaValueDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
]

{ #category : 'testing' }
ViennaValueDefinitionNode >> isViennaTopLevelDefinitionNode [

	^ (self detectParent: #isViennaLetNode ifNone: [ nil ]) isNil
]

{ #category : 'testing' }
ViennaValueDefinitionNode >> isViennaValueDefinitionNode [

	^ true
]

{ #category : 'accessing' }
ViennaValueDefinitionNode >> label [

	^ 'ValueDefinition'
]

{ #category : 'typechecking' }
ViennaValueDefinitionNode >> maximalType [

	| leftType rightType |
	leftType := self pattern maximalType
	            &
	            (self type ifNotNil: #typecheck ifNil: [ ViennaType any ]).
	rightType := self expression typecheck: leftType.
	self pattern maximalType: rightType.
	^ ViennaType unit
]

{ #category : 'accessing' }
ViennaValueDefinitionNode >> pattern [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaValueDefinitionNode >> pattern: aViennaPatternNode [

	self at: 2 put: aViennaPatternNode
]

{ #category : 'purity and transparency' }
ViennaValueDefinitionNode >> purityCheck [

	
]

{ #category : 'class membership' }
ViennaValueDefinitionNode >> respondsTo: aSymbol [

	aSymbol = #identifier: ifTrue: [
		^ self hasOnlyOnePatternIdentifier ].
	^ super respondsTo: aSymbol
]

{ #category : 'purity and transparency' }
ViennaValueDefinitionNode >> transparencyCheck [

	self expression transparencyCheck
]

{ #category : 'accessing' }
ViennaValueDefinitionNode >> type [

	^ self at: 3
]

{ #category : 'accessing' }
ViennaValueDefinitionNode >> type: aViennaTypeNode [

	self at: 3 put: aViennaTypeNode
]
