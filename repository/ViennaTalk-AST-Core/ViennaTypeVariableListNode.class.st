Class {
	#name : 'ViennaTypeVariableListNode',
	#superclass : 'ViennaDefinitionComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'private' }
ViennaTypeVariableListNode >> boundIdentifiersDo: aBlock [

	self do: [ :typeVariable | typeVariable boundIdentifiersDo: aBlock ]
]

{ #category : 'pretty printing' }
ViennaTypeVariableListNode >> formatWith: aViennaAbstractFormatter [

	^ self size > 0
		  ifTrue: [
			  aViennaAbstractFormatter empty ++ '['
			  ++ (aViennaAbstractFormatter
					   join: ','
					   withAll: (aViennaAbstractFormatter formatAll: self)) ++ ']' ]
		  ifFalse: [ aViennaAbstractFormatter empty ]
]

{ #category : 'private' }
ViennaTypeVariableListNode >> freeIdentifiersExcept: aSet do: aBlock [

	
]

{ #category : 'testing' }
ViennaTypeVariableListNode >> isViennaTypeVariableListNode [

	^ true
]

{ #category : 'accessing' }
ViennaTypeVariableListNode >> label [

	^ 'TypeVariableList'
]

{ #category : 'typechecking' }
ViennaTypeVariableListNode >> maximalType [

	^ ViennaType product: (self collect: #typecheck)
]
