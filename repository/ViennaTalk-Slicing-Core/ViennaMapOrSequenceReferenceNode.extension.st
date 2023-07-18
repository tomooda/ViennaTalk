Extension { #name : #ViennaMapOrSequenceReferenceNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaMapOrSequenceReferenceNode >> sliceWith: aViennaSlicer [

	self argumentExpression sliceWith: aViennaSlicer.
	self stateDesignator isViennaNameNode
		ifTrue: [ aViennaSlicer write: self stateDesignator ]
		ifFalse: [ self stateDesignator sliceWith: aViennaSlicer ]
]
