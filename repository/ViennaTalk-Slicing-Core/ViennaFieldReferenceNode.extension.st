Extension { #name : #ViennaFieldReferenceNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaFieldReferenceNode >> sliceWith: aViennaSlicer [

	self stateDesignator isViennaNameNode
		ifTrue: [ aViennaSlicer write: self stateDesignator ]
		ifFalse: [ self stateDesignator sliceWith: aViennaSlicer ]
]
