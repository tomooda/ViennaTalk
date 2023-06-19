Class {
	#name : #ViennaMultipleSetSeqBindNode,
	#superclass : #ViennaMultipleBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
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

{ #category : #testing }
ViennaMultipleSetSeqBindNode >> isViennaMultipleSetSeqBindNode [

	^ true
]
