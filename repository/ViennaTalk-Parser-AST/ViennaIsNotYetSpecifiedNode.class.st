Class {
	#name : #ViennaIsNotYetSpecifiedNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaIsNotYetSpecifiedNode >> boundIdentifiersInto: aSet [

	
]

{ #category : #'pretty printing' }
ViennaIsNotYetSpecifiedNode >> formatWith: aViennaAbstractFormatter [

	^ 'is not yet specified'
]

{ #category : #testing }
ViennaIsNotYetSpecifiedNode >> isViennaIsNotYetSpecifiedNode [

	^ true
]

{ #category : #accessing }
ViennaIsNotYetSpecifiedNode >> label [

	^ 'IsNotYetSpecified'
]
