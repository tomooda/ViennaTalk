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
ViennaAccessTypeDefinitionNode >> typeDefinition [

	^ self at: 2
]

{ #category : #accessing }
ViennaAccessTypeDefinitionNode >> typeDefinition: aViennaTypeDefinitionNode [

	self at: 2 put: aViennaTypeDefinitionNode
]
