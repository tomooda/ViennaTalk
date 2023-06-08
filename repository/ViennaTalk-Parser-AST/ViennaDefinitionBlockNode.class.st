Class {
	#name : #ViennaDefinitionBlockNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaDefinitionBlockNode >> formatWith: aViennaAbstractFormatter [

	^ (aViennaAbstractFormatter format: self first) , String cr
]

{ #category : #'as yet unclassified' }
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
