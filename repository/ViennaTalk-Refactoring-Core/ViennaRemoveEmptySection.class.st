Class {
	#name : #ViennaRemoveEmptySection,
	#superclass : #ViennaRemove,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRemoveEmptySection >> check [
	^ self definitionNode notNil
]

{ #category : #operations }
ViennaRemoveEmptySection >> execute [
	self definitionNode parent parent remove: self definitionNode parent
]

{ #category : #accessing }
ViennaRemoveEmptySection >> findDefinitionNode [

	(#( 'TypeDefinitions' 'ValueDefinitions' 'FunctionDefinitions'
	    'OperationDefinitions' ) includes: ast label) ifFalse: [ ^ nil ].
	ast isEmpty ifTrue: [ ^ ast ].
	^ nil
]

{ #category : #accessing }
ViennaRemoveEmptySection >> name [
	^ 'Remove ' , self definitionNode name asText allBold, ' section'
]

{ #category : #accessing }
ViennaRemoveEmptySection >> sortingOrder [
	^ 0.1
]
