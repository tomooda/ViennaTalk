Class {
	#name : 'ViennaDocumentNode',
	#superclass : 'ViennaNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'testing' }
ViennaDocumentNode class >> isAbstract [

	^ self = ViennaDocumentNode
]

{ #category : 'private' }
ViennaDocumentNode >> boundIdentifiersDo: aBlock [

	self do: [ :node | node boundIdentifiersDo: aBlock ]
]

{ #category : 'accessing' }
ViennaDocumentNode >> document [

	^ self
]

{ #category : 'accessing-definitions' }
ViennaDocumentNode >> findResolverForIdentifier: aString [

	^ self subclassResponsibility
]

{ #category : 'pretty printing' }
ViennaDocumentNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: aViennaAbstractFormatter cr
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : 'private' }
ViennaDocumentNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :node | node freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : 'testing' }
ViennaDocumentNode >> hasScope [

	^ true
]

{ #category : 'testing' }
ViennaDocumentNode >> hasTests [

	self testOperationsDo: [ :operation | ^ true ].
	self namedTracesDo: [ :trace | ^ true ].
	^ false
]

{ #category : 'testing' }
ViennaDocumentNode >> isViennaDocumentNode [

	^ true
]

{ #category : 'accessing' }
ViennaDocumentNode >> label [

	^ 'Document'
]

{ #category : 'enumerating' }
ViennaDocumentNode >> namedTracesDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'purity and transparency' }
ViennaDocumentNode >> purityCheck [

	self toplevelDefinitionsDo: [ :toplevelDefinitionNode |
		toplevelDefinitionNode purityCheck ]
]

{ #category : 'purity and transparency' }
ViennaDocumentNode >> semanticCheck [

	self
		transparencyCheck;
		purityCheck;
		forgetTypecheck;
		typecheck
]

{ #category : 'enumerating' }
ViennaDocumentNode >> testOperationsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'enumerating' }
ViennaDocumentNode >> toplevelDefinitionsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'purity and transparency' }
ViennaDocumentNode >> transparencyCheck [

	self toplevelDefinitionsDo: [ :toplevelDefinitionNode |
		toplevelDefinitionNode transparencyCheck ]
]
