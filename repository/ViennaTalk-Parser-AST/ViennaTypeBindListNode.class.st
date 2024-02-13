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

{ #category : #private }
ViennaTypeBindListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :typeBind |
		typeBind freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaTypeBindListNode >> isViennaTypeBindListNode [

	^ true
]

{ #category : #accessing }
ViennaTypeBindListNode >> label [

	^ 'TypeBindList'
]

{ #category : #typechecking }
ViennaTypeBindListNode >> maximalType [

	self do: [ :bind | bind typecheck: ViennaType unit ].
	^ ViennaType unit
]

{ #category : #typechecking }
ViennaTypeBindListNode >> maximalType: aViennaType [

	self do: [ :bind | bind maximalType: aViennaType ].
	super maximalType: self maximalType
]
