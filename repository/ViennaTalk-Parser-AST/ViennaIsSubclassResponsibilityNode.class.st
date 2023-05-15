Class {
	#name : #ViennaIsSubclassResponsibilityNode,
	#superclass : #ViennaReservedNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaIsSubclassResponsibilityNode >> formatWith: aViennaAbstractFormatter [

	^ 'is subclass responsibility'
]

{ #category : #accessing }
ViennaIsSubclassResponsibilityNode >> label [

	^ 'IsSubclassResponsibility'
]
