Class {
	#name : #ViennaTypeBindListNode,
	#superclass : #ViennaPatternBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaTypeBindListNode >> boundIdentifiersInto: aSet [

	self do: [ :pattern | pattern boundIdentifiersInto: aSet ]
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
