Class {
	#name : 'ViennaSetSeqBindNode',
	#superclass : 'ViennaBindNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'testing' }
ViennaSetSeqBindNode class >> isAbstract [

	^ self = ViennaSetSeqBindNode
]

{ #category : 'instance creation' }
ViennaSetSeqBindNode class >> pattern: aViennaPatternNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  pattern: aViennaPatternNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : 'accessing' }
ViennaSetSeqBindNode >> expression [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaSetSeqBindNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : 'private' }
ViennaSetSeqBindNode >> freeIdentifiersExcept: aSet do: aBlock [

	self pattern freeIdentifiersExcept: aSet do: aBlock.
	self expression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'testing' }
ViennaSetSeqBindNode >> isViennaSetSeqBindNode [

	^ true
]
