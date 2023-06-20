Class {
	#name : #ViennaLocalDefinitionNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaLocalDefinitionNode class >> valueDefinitionOrFunctionDefinition: aViennaNode [

	^ (self new: 1)
		  valueDefinitionOrFunctionDefinition: aViennaNode;
		  yourself
]

{ #category : #private }
ViennaLocalDefinitionNode >> boundIdentifiersDo: aBlock [

	self valueDefinitionOrFunctionDefinition boundIdentifiersDo: aBlock
]

{ #category : #'pretty printing' }
ViennaLocalDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter format: self first
]

{ #category : #private }
ViennaLocalDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self valueDefinitionOrFunctionDefinition
		freeIdentifiersExcept: aSet
		do: aBlock
]

{ #category : #testing }
ViennaLocalDefinitionNode >> isViennaLocalDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaLocalDefinitionNode >> label [

	^ 'LocalDefinition'
]

{ #category : #accessing }
ViennaLocalDefinitionNode >> valueDefinitionOrFunctionDefinition [

	^ self at: 1
]

{ #category : #accessing }
ViennaLocalDefinitionNode >> valueDefinitionOrFunctionDefinition: aViennaNode [

	self at: 1 put: aViennaNode
]
