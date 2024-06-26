Class {
	#name : 'ViennaPatternIdentifierNode',
	#superclass : 'ViennaPatternNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaPatternIdentifierNode class >> anonymous [

	^ self identifier: nil
]

{ #category : 'instance creation' }
ViennaPatternIdentifierNode class >> identifier: aString [

	^ (self new: 1)
		  identifier: aString;
		  yourself
]

{ #category : 'converting' }
ViennaPatternIdentifierNode >> asExpression [

	^ ViennaLocalNameNode identifier: self identifier
]

{ #category : 'private' }
ViennaPatternIdentifierNode >> boundIdentifiersDo: aBlock [

	self identifier ifNotNil: [ :identifier |
		aBlock cull: identifier cull: self ]
]

{ #category : 'pretty printing' }
ViennaPatternIdentifierNode >> formatWith: aViennaAbstractFormatter [

	^ self identifier
		  ifNil: [ aViennaAbstractFormatter empty ++ '-' ]
		  ifNotNil: [ :identifier |
		  aViennaAbstractFormatter format: identifier ]
]

{ #category : 'private' }
ViennaPatternIdentifierNode >> freeIdentifiersExcept: aSet do: aBlock [
]

{ #category : 'accessing' }
ViennaPatternIdentifierNode >> identifier [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaPatternIdentifierNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : 'testing' }
ViennaPatternIdentifierNode >> isViennaPatternIdentifierNode [

	^ true
]

{ #category : 'testing' }
ViennaPatternIdentifierNode >> isViennaPatternIdentifierNode: aString [

	^ self identifier = aString
]

{ #category : 'accessing' }
ViennaPatternIdentifierNode >> label [

	^ 'PatternIdentifier'
]

{ #category : 'typechecking' }
ViennaPatternIdentifierNode >> maximalType [

	^ ViennaType any
]

{ #category : 'accessing' }
ViennaPatternIdentifierNode >> shortName [

	^ self identifier
]
