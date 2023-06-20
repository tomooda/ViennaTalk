Class {
	#name : #ViennaTypeVariableListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaTypeVariableListNode >> boundIdentifiersDo: aBlock [

	self do: [ :typeVariable | typeVariable boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaTypeVariableListNode >> formatWith: aViennaAbstractFormatter [

	^ self size > 0
		  ifTrue: [
			  '[' , (aViennaAbstractFormatter
				   join: String space
				   withAll: (aViennaAbstractFormatter formatAll: self)) , ']' ]
		  ifFalse: [ '' ]
]

{ #category : #private }
ViennaTypeVariableListNode >> freeIdentifiersExcept: aSet do: aBlock [

	
]

{ #category : #testing }
ViennaTypeVariableListNode >> isViennaTypeVariableListNode [

	^ true
]

{ #category : #accessing }
ViennaTypeVariableListNode >> label [

	^ 'TypeVariableList'
]
