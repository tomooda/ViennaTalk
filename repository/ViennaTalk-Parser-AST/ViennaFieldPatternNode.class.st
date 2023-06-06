Class {
	#name : #ViennaFieldPatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaFieldPatternNode class >> identifier: aString pattern: aViennaPatternNode [

	^ (self new: 2)
		  identifier: aString;
		  pattern: aViennaPatternNode;
		  yourself
]

{ #category : #'pretty printing' }
ViennaFieldPatternNode >> formatWith: aViennaAbstractFormatter [

	| identifier pattern |
	identifier := aViennaAbstractFormatter format: self identifier.
	pattern := aViennaAbstractFormatter format: self pattern.
	^ identifier , ' ' , aViennaAbstractFormatter maplet , ' ' , pattern
]

{ #category : #accessing }
ViennaFieldPatternNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaFieldPatternNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #testing }
ViennaFieldPatternNode >> isViennaFieldPatternNode [

	^ true
]

{ #category : #accessing }
ViennaFieldPatternNode >> label [

	^ 'FieldPattern'
]

{ #category : #accessing }
ViennaFieldPatternNode >> pattern [

	^ self at: 2
]

{ #category : #accessing }
ViennaFieldPatternNode >> pattern: aViennaPatternNode [

	self at: 2 put: aViennaPatternNode
]
