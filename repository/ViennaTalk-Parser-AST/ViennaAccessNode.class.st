Class {
	#name : #ViennaAccessNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaAccessNode class >> pure [

	^ self with: 'pure'
]

{ #category : #private }
ViennaAccessNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaAccessNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ' '
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #private }
ViennaAccessNode >> freeIdentifiersExcept: aSet do: aBlock [

	
]

{ #category : #testing }
ViennaAccessNode >> isViennaAccessNode [

	^ true
]

{ #category : #accessing }
ViennaAccessNode >> label [

	^ 'Access'
]

{ #category : #typechecking }
ViennaAccessNode >> maximalType [

	^ ViennaType unit
]
