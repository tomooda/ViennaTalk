Class {
	#name : #ViennaTypeVariableListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaTypeVariableListNode >> boundIdentifiersInto: aSet [

	self do: [ :typeVariable | typeVariable boundIdentifiersInto: aSet ]
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

{ #category : #testing }
ViennaTypeVariableListNode >> isViennaTypeVariableListNode [

	^ true
]

{ #category : #accessing }
ViennaTypeVariableListNode >> label [

	^ 'TypeVariableList'
]
