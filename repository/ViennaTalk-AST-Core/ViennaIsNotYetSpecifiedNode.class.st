Class {
	#name : #ViennaIsNotYetSpecifiedNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #private }
ViennaIsNotYetSpecifiedNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaIsNotYetSpecifiedNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter keyword: 'is not yet specified'
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

{ #category : #typechecking }
ViennaIsNotYetSpecifiedNode >> maximalType [

	^ ViennaType any
]
