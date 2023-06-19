Class {
	#name : #ViennaPatternListNode,
	#superclass : #ViennaPatternBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaPatternListNode >> formatWith: aViennaAbstractFormatter [

	| patterns |
	patterns := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  join: ',' , ((aViennaAbstractFormatter anyNeedsIndent: patterns)
				   ifTrue: [ String cr ]
				   ifFalse: [ String space ])
		  withAll: patterns
]

{ #category : #testing }
ViennaPatternListNode >> isViennaPatternListNode [

	^ true
]

{ #category : #accessing }
ViennaPatternListNode >> label [

	^ 'PatternList'
]
