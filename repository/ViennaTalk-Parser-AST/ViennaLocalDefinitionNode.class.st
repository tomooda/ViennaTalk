Class {
	#name : #ViennaLocalDefinitionNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaLocalDefinitionNode class >> with: aViennaNode [

	^ (self new: 1)
		  at: 1 put: aViennaNode;
		  yourself
]

{ #category : #'pretty printing' }
ViennaLocalDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter format: self first
]

{ #category : #accessing }
ViennaLocalDefinitionNode >> label [

	^ 'LocalDefinition'
]
