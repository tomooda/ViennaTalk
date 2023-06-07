Class {
	#name : #ViennaSeqConcPatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSeqConcPatternNode >> formatWith: aViennaAbstractFormatter [

	| patterns |
	patterns := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  join: ((aViennaAbstractFormatter anyNeedsIndent: patterns)
				   ifTrue: [ String cr , aViennaAbstractFormatter concat ]
				   ifFalse: [ aViennaAbstractFormatter concat ])
		  withAll: patterns
]

{ #category : #testing }
ViennaSeqConcPatternNode >> isViennaSeqConcPatternNode [

	^ true
]

{ #category : #accessing }
ViennaSeqConcPatternNode >> label [

	^ 'SeqConcPattern'
]
