Class {
	#name : #ViennaAccessTypeDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaAccessTypeDefinitionNode class >> access: aViennaAccessNode typeDefinition: aViennaTypeDefinitionNode [

	^ (self new: 2)
		  access: aViennaAccessNode;
		  typeDefinition: aViennaTypeDefinitionNode;
		  yourself
]

{ #category : #accessing }
ViennaAccessTypeDefinitionNode >> access [

	^ self at: 1
]

{ #category : #accessing }
ViennaAccessTypeDefinitionNode >> access: aViennaAccessNode [

	self at: 1 put: aViennaAccessNode
]

{ #category : #private }
ViennaAccessTypeDefinitionNode >> boundIdentifiersDo: aBlock [

	self typeDefinition boundIdentifiersDo: aBlock
]

{ #category : #accessing }
ViennaAccessTypeDefinitionNode >> definitionBase [

	^ self typeDefinition
]

{ #category : #'pretty printing' }
ViennaAccessTypeDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ' '
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #testing }
ViennaAccessTypeDefinitionNode >> isViennaAccessTypeDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaAccessTypeDefinitionNode >> label [

	^ 'AccessTypeDefinition'
]

{ #category : #accessing }
ViennaAccessTypeDefinitionNode >> resolve [

	^ self typeDefinition resolve
]

{ #category : #accessing }
ViennaAccessTypeDefinitionNode >> shortName [

	^ self typeDefinition shortName
]

{ #category : #accessing }
ViennaAccessTypeDefinitionNode >> typeDefinition [

	^ self at: 2
]

{ #category : #accessing }
ViennaAccessTypeDefinitionNode >> typeDefinition: aViennaTypeDefinitionNode [

	self at: 2 put: aViennaTypeDefinitionNode
]
