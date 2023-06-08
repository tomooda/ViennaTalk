Class {
	#name : #ViennaAccessTypeDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaAccessTypeDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ' '
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #'as yet unclassified' }
ViennaAccessTypeDefinitionNode >> isViennaAccessTypeDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaAccessTypeDefinitionNode >> label [

	^ 'AccessTypeDefinition'
]
