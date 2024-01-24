Class {
	#name : #ViennaFieldListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #converting }
ViennaFieldListNode >> asMaximalViennaType [

	^ self collect: #asMaximalViennaType
]

{ #category : #private }
ViennaFieldListNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaFieldListNode >> formatWith: aViennaAbstractFormatter [

	| fields |
	fields := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  join: ((aViennaAbstractFormatter anyNeedsIndent: fields)
				   ifTrue: [ String cr ]
				   ifFalse: [ String space ])
		  withAll: fields
]

{ #category : #private }
ViennaFieldListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :field | field freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaFieldListNode >> isViennaFieldListNode [

	^ true
]

{ #category : #accessing }
ViennaFieldListNode >> label [

	^ 'FieldList'
]
