Class {
	#name : #ViennaTranspiledObject,
	#superclass : #Object,
	#category : 'ViennaTalk-Parser-Code Generators'
}

{ #category : #private }
ViennaTranspiledObject >> state [
	^ (ViennaComposite constructorName: '')
]
