Class {
	#name : #ViennaUnitTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #converting }
ViennaUnitTypeNode >> asMaximalViennaType [

	^ ViennaType unit
]

{ #category : #'pretty printing' }
ViennaUnitTypeNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter typeName: '()'
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
