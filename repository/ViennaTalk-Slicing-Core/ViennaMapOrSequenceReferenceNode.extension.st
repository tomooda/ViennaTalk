Extension { #name : 'ViennaMapOrSequenceReferenceNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaMapOrSequenceReferenceNode >> sliceArgumentsWith: aViennaSlicer [

	self argumentExpression sliceWith: aViennaSlicer.
	self stateDesignator sliceArgumentsWith: aViennaSlicer
]

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaMapOrSequenceReferenceNode >> sliceReadWith: aViennaSlicer [

	aViennaSlicer onNode: self.
	aViennaSlicer read: self argumentExpression.
	self stateDesignator sliceReadWith: aViennaSlicer
]

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaMapOrSequenceReferenceNode >> sliceWith: aViennaSlicer [

	^ self shouldNotImplement
]

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaMapOrSequenceReferenceNode >> sliceWriteWith: aViennaSlicer [

	aViennaSlicer onNode: self.
	self stateDesignator sliceWriteWith: aViennaSlicer
]
