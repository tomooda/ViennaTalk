Class {
	#name : #ViennaFieldListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaFieldListNode >> boundIdentifiersInto: aSet [

	
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

{ #category : #testing }
ViennaFieldListNode >> isViennaFieldListNode [

	^ true
]

{ #category : #accessing }
ViennaFieldListNode >> label [

	^ 'FieldList'
]
