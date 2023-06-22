Class {
	#name : #ViennaAccessOperationDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaAccessOperationDefinitionNode class >> access: aViennaAccessNode operationDefinition: aViennaOperationDefinitionNode [

	^ (self new: 2)
		  access: aViennaAccessNode;
		  operationDefinition: aViennaOperationDefinitionNode;
		  yourself
]

{ #category : #accessing }
ViennaAccessOperationDefinitionNode >> access [

	^ self at: 1
]

{ #category : #accessing }
ViennaAccessOperationDefinitionNode >> access: aViennaAccessNode [

	self at: 1 put: aViennaAccessNode
]

{ #category : #private }
ViennaAccessOperationDefinitionNode >> boundIdentifiersDo: aBlock [

	self operationDefinition boundIdentifiersDo: aBlock
]

{ #category : #'pretty printing' }
ViennaAccessOperationDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ' '
		  withAll:
		  ((aViennaAbstractFormatter formatAll: self) reject: #isEmpty)
]

{ #category : #private }
ViennaAccessOperationDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self operationDefinition freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaAccessOperationDefinitionNode >> identifier [

	^ self operationDefinition identifier
]

{ #category : #testing }
ViennaAccessOperationDefinitionNode >> isViennaAccessOperationDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaAccessOperationDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaAccessOperationDefinitionNode >> label [

	^ 'AccessOperationDefinition'
]

{ #category : #accessing }
ViennaAccessOperationDefinitionNode >> operationDefinition [

	^ self at: 2
]

{ #category : #accessing }
ViennaAccessOperationDefinitionNode >> operationDefinition: aViennaOperationDefinitionNode [

	self at: 2 put: aViennaOperationDefinitionNode
]

{ #category : #'accessing-definitions' }
ViennaAccessOperationDefinitionNode >> resolve [

	^ self operationDefinition resolve
]

{ #category : #'accessing-definitions' }
ViennaAccessOperationDefinitionNode >> shortName [

	^ self operationDefinition shortName
]
