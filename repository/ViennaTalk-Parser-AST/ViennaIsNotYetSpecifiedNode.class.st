Class {
	#name : #ViennaIsNotYetSpecifiedNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaIsNotYetSpecifiedNode >> formatWith: aViennaAbstractFormatter [

	^ 'is not yet specified'
]

{ #category : #accessing }
ViennaIsNotYetSpecifiedNode >> label [

	^ 'IsNotYetSpecified'
]
