Class {
	#name : #ViennaSetUnionPatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaSetUnionPatternNode class >> pattern: aViennaPatternNode1 pattern: aViennaPatternNode2 [

	^ (self new: 2)
		  pattern1: aViennaPatternNode1;
		  pattern2: aViennaPatternNode2;
		  yourself
]

{ #category : #private }
ViennaSetUnionPatternNode >> boundIdentifiersDo: aBlock [

	self pattern1 boundIdentifiersDo: aBlock.
	self pattern2 boundIdentifiersDo: aBlock
]

{ #category : #'pretty printing' }
ViennaSetUnionPatternNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self pattern1)
		  infix: aViennaAbstractFormatter union
		  arg: (aViennaAbstractFormatter format: self pattern2)
]

{ #category : #testing }
ViennaSetUnionPatternNode >> isViennaSetUnionPatternNode [

	^ true
]

{ #category : #accessing }
ViennaSetUnionPatternNode >> label [

	^ 'SetUnionPattern'
]

{ #category : #accessing }
ViennaSetUnionPatternNode >> pattern1 [

	^ self at: 1
]

{ #category : #accessing }
ViennaSetUnionPatternNode >> pattern1: aViennaPatternNode [

	self at: 1 put: aViennaPatternNode
]

{ #category : #accessing }
ViennaSetUnionPatternNode >> pattern2 [

	^ self at: 2
]

{ #category : #accessing }
ViennaSetUnionPatternNode >> pattern2: aViennaPatternNode [

	self at: 2 put: aViennaPatternNode
]
