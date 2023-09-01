Extension { #name : #ViennaBlockStatementNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaBlockStatementNode >> sliceWith: aViennaSlicer [

	self reverseDo: [ :statement | statement sliceWith: aViennaSlicer ]
]
