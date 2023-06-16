Class {
	#name : #ViennaOperationDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaOperationDefinitionNode class >> definition: aViennaNode [

	^ (self new: 1)
		  definition: aViennaNode;
		  yourself
]

{ #category : #accessing }
ViennaOperationDefinitionNode >> definition [

	^ self at: 1
]

{ #category : #accessing }
ViennaOperationDefinitionNode >> definition: aViennaNode [

	self at: 1 put: aViennaNode
]

{ #category : #'pretty printing' }
ViennaOperationDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter format: self definition
]

{ #category : #accessing }
ViennaOperationDefinitionNode >> identifier [

	^ self definition identifier
]

{ #category : #testing }
ViennaOperationDefinitionNode >> isViennaOperationDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaOperationDefinitionNode >> isViennaOperationDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : #testing }
ViennaOperationDefinitionNode >> label [

	^ 'OperationDefinition'
]

{ #category : #'accessing-definitions' }
ViennaOperationDefinitionNode >> resolve [

	^ self definition
]

{ #category : #'accessing-definitions' }
ViennaOperationDefinitionNode >> shortName [

	^ self definition shortName
]
