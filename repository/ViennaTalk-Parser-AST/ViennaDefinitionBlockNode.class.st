Class {
	#name : #ViennaDefinitionBlockNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaDefinitionBlockNode class >> definition: aViennaNode [

	^ (self new: 1)
		  definition: aViennaNode;
		  yourself
]

{ #category : #accessing }
ViennaDefinitionBlockNode >> definition [

	^ self at: 1
]

{ #category : #accessing }
ViennaDefinitionBlockNode >> definition: aViennaNode [

	self at: 1 put: aViennaNode
]

{ #category : #'pretty printing' }
ViennaDefinitionBlockNode >> formatWith: aViennaAbstractFormatter [

	^ (aViennaAbstractFormatter format: self definition) , String cr
]

{ #category : #testing }
ViennaDefinitionBlockNode >> isViennaDefinitionBlockNode [

	^ true
]

{ #category : #accessing }
ViennaDefinitionBlockNode >> label [

	^ 'DefinitionBlock'
]

{ #category : #accessing }
ViennaDefinitionBlockNode >> section [
	^ self at: 1
]
