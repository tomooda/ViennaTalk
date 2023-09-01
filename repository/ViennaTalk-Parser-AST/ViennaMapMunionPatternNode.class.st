Class {
	#name : #ViennaMapMunionPatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaMapMunionPatternNode class >> pattern: aViennaPatternNode1 pattern: aViennaPatternNode2 [

	^ (self new: 2)
		  pattern1: aViennaPatternNode1;
		  pattern2: aViennaPatternNode2;
		  yourself
]

{ #category : #private }
ViennaMapMunionPatternNode >> boundIdentifiersDo: aBlock [

	self pattern1 boundIdentifiersDo: aBlock.
	self pattern2 boundIdentifiersDo: aBlock
]

{ #category : #'pretty printing' }
ViennaMapMunionPatternNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self pattern1)
		  infix: aViennaAbstractFormatter munion
		  arg: (aViennaAbstractFormatter format: self pattern2)
]

{ #category : #private }
ViennaMapMunionPatternNode >> freeIdentifiersExcept: aSet do: aBlock [

	self pattern1 freeIdentifiersExcept: aSet do: aBlock.
	self pattern2 freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaMapMunionPatternNode >> isViennaMapMunionPatternNode [

	^ true
]

{ #category : #accessing }
ViennaMapMunionPatternNode >> label [

	^ 'MapMunionPattern'
]

{ #category : #accessing }
ViennaMapMunionPatternNode >> pattern1 [

	^ self at: 1
]

{ #category : #accessing }
ViennaMapMunionPatternNode >> pattern1: aViennaPatternNode [

	self at: 1 put: aViennaPatternNode
]

{ #category : #accessing }
ViennaMapMunionPatternNode >> pattern2 [

	^ self at: 2
]

{ #category : #accessing }
ViennaMapMunionPatternNode >> pattern2: aViennaPatternNode [

	self at: 2 put: aViennaPatternNode
]
