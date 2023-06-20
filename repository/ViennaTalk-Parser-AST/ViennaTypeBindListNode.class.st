Class {
	#name : #ViennaTypeBindListNode,
	#superclass : #ViennaPatternBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaTypeBindListNode >> boundIdentifiersDo: aBlock [

	self do: [ :pattern | pattern boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaTypeBindListNode >> formatWith: aViennaAbstractFormatter [

	| patterns |
	patterns := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  join: ',' , ((aViennaAbstractFormatter anyNeedsIndent: patterns)
				   ifTrue: [ String cr ]
				   ifFalse: [ String space ])
		  withAll: patterns
]

{ #category : #testing }
ViennaTypeBindListNode >> isViennaTypeBindListNode [

	^ true
]

{ #category : #accessing }
ViennaTypeBindListNode >> label [

	^ 'TypeBindList'
]
