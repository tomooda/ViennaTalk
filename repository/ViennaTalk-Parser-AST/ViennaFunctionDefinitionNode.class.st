Class {
	#name : #ViennaFunctionDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaFunctionDefinitionNode class >> definition: aViennaNode [

	^ (self new: 1)
		  definition: aViennaNode;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaFunctionDefinitionNode >> asAccessDefinition [

	^ ViennaAccessFunctionDefinitionNode
		  access: ViennaAccessNode empty
		  functionDefinition: self
]

{ #category : #private }
ViennaFunctionDefinitionNode >> boundIdentifiersDo: aBlock [

	self definition boundIdentifiersDo: aBlock
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> definition [

	^ self at: 1
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> definition: aViennaNode [

	self at: 1 put: aViennaNode
]

{ #category : #'pretty printing' }
ViennaFunctionDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter format: self definition
]

{ #category : #private }
ViennaFunctionDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self definition freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> identifier [

	^ self definition identifier
]

{ #category : #testing }
ViennaFunctionDefinitionNode >> isViennaFunctionDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaFunctionDefinitionNode >> isViennaFunctionDefinitionNode: aString [

	^ self definition identifier = aString
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> label [

	^ 'FunctionDefinition'
]

{ #category : #'accessing-definitions' }
ViennaFunctionDefinitionNode >> resolve [

	^ self definition
]

{ #category : #'accessing-definitions' }
ViennaFunctionDefinitionNode >> shortName [

	^ self definition shortName
]
