Class {
	#name : #ViennaIsNotYetSpecifiedNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaIsNotYetSpecifiedNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaIsNotYetSpecifiedNode >> formatWith: aViennaAbstractFormatter [

	^ 'is not yet specified'
]

{ #category : #private }
ViennaIsNotYetSpecifiedNode >> freeIdentifiersExcept: aSet do: aBlock [

	
]

{ #category : #testing }
ViennaIsNotYetSpecifiedNode >> isViennaIsNotYetSpecifiedNode [

	^ true
]

{ #category : #accessing }
ViennaIsNotYetSpecifiedNode >> label [

	^ 'IsNotYetSpecified'
]
