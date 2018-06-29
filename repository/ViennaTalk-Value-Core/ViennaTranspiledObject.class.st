Class {
	#name : #ViennaTranspiledObject,
	#superclass : #Object,
	#category : 'ViennaTalk-Value-Core'
}

{ #category : #private }
ViennaTranspiledObject >> state [
	^ (ViennaComposite constructorName: '')
]
