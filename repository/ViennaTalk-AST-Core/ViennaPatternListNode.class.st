Class {
	#name : 'ViennaPatternListNode',
	#superclass : 'ViennaPatternBindNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'converting' }
ViennaPatternListNode >> asExpression [

	^ ViennaExpressionListNode withAll: (self collect: #asExpression)
]

{ #category : 'private' }
ViennaPatternListNode >> boundIdentifiersDo: aBlock [

	self do: [ :pattern | pattern boundIdentifiersDo: aBlock ]
]

{ #category : 'pretty printing' }
ViennaPatternListNode >> formatWith: aViennaAbstractFormatter [

	| patterns |
	patterns := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  join: aViennaAbstractFormatter empty ++ ','
			  ++ ((aViennaAbstractFormatter anyNeedsIndent: patterns)
					   ifTrue: [ aViennaAbstractFormatter cr ]
					   ifFalse: [ aViennaAbstractFormatter space ])
		  withAll: patterns
]

{ #category : 'private' }
ViennaPatternListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :pattern | pattern freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : 'testing' }
ViennaPatternListNode >> isViennaPatternListNode [

	^ true
]

{ #category : 'accessing' }
ViennaPatternListNode >> label [

	^ 'PatternList'
]

{ #category : 'private' }
ViennaPatternListNode >> listDelimiter [

	^ ', '
]

{ #category : 'typechecking' }
ViennaPatternListNode >> maximalType [

	| type |
	type := ViennaType unit.
	self do: [ :pattern | type := type + pattern typecheck ].
	^ type
]

{ #category : 'typechecking' }
ViennaPatternListNode >> maximalType: aViennaType [

	self do: [ :pattern | pattern maximalType: aViennaType ].
	super maximalType: self maximalType
]
