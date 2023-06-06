Class {
	#name : #ViennaFieldPatternListNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaFieldPatternListNode >> formatWith: aViennaAbstractFormatter [

	| fieldPatterns |
	fieldPatterns := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  join:
			  ',' , ((aViennaAbstractFormatter anyNeedsIndent: fieldPatterns)
				   ifTrue: [ String cr ]
				   ifFalse: [ String space ])
		  withAll: fieldPatterns
]

{ #category : #testing }
ViennaFieldPatternListNode >> isViennaFieldPatternListNode [

	^ true
]

{ #category : #accessing }
ViennaFieldPatternListNode >> label [

	^ 'FieldPatternList'
]
