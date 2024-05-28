Extension { #name : 'ViennaFieldReferenceNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaFieldReferenceNode >> sliceArgumentsWith: aViennaSlicer [

	self stateDesignator sliceArgumentsWith: aViennaSlicer
]

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaFieldReferenceNode >> sliceReadWith: aViennaSlicer [

	aViennaSlicer onNode: self.
	self stateDesignator sliceReadWith: aViennaSlicer
]

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaFieldReferenceNode >> sliceWith: aViennaSlicer [

	^ self shouldNotImplement
]

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaFieldReferenceNode >> sliceWriteWith: aViennaSlicer [

	aViennaSlicer onNode: self.
	self stateDesignator sliceWriteWith: aViennaSlicer
]
