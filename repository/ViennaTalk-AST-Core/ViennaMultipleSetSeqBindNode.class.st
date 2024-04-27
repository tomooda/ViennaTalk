Class {
	#name : #ViennaMultipleSetSeqBindNode,
	#superclass : #ViennaMultipleBindNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #testing }
ViennaMultipleSetSeqBindNode class >> isAbstract [

	^ self = ViennaMultipleSetSeqBindNode
]

{ #category : #'instance creation' }
ViennaMultipleSetSeqBindNode class >> patternList: aViennaPatternListNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  patternList: aViennaPatternListNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaMultipleSetSeqBindNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaMultipleSetSeqBindNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #private }
ViennaMultipleSetSeqBindNode >> freeIdentifiersExcept: aSet do: aBlock [

	self patternList freeIdentifiersExcept: aSet do: aBlock.
	self expression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaMultipleSetSeqBindNode >> isViennaMultipleSetSeqBindNode [

	^ true
]
