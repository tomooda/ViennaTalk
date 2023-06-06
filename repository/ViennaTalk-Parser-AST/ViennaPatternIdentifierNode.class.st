Class {
	#name : #ViennaPatternIdentifierNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaPatternIdentifierNode class >> anonymous [

	^ self identifier: nil
]

{ #category : #'instance creation' }
ViennaPatternIdentifierNode class >> identifier: aString [

	^ (self new: 1)
		  identifier: aString;
		  yourself
]

{ #category : #'pretty printing' }
ViennaPatternIdentifierNode >> formatWith: aViennaAbstractFormatter [

	^ self identifier
		  ifNil: [ '-' ]
		  ifNotNil: [ :identifier |
		  aViennaAbstractFormatter format: identifier ]
]

{ #category : #accessing }
ViennaPatternIdentifierNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaPatternIdentifierNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #testing }
ViennaPatternIdentifierNode >> isViennaPatternIdentifierNode [

	^ true
]

{ #category : #testing }
ViennaPatternIdentifierNode >> isViennaPatternIdentifierNode: aString [

	^ self identifier = aString
]

{ #category : #accessing }
ViennaPatternIdentifierNode >> label [

	^ 'PatternIdentifier'
]

{ #category : #accessing }
ViennaPatternIdentifierNode >> name [

	^ self identifier
]
