Class {
	#name : #ViennaUnitTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaUnitTypeNode >> formatWith: aViennaAbstractFormatter [

	^ '()'
]

{ #category : #private }
ViennaUnitTypeNode >> freeIdentifiersExcept: aSet do: aBlock [
]

{ #category : #testing }
ViennaUnitTypeNode >> isViennaUnitTypeNode [

	^ true
]

{ #category : #accessing }
ViennaUnitTypeNode >> label [

	^ 'UnitType'
]
