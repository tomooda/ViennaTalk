Extension { #name : #ViennaMultipleAssignStatementNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaMultipleAssignStatementNode >> sliceWith: aViennaSlicer [

	self reverseDo: [ :statement | statement sliceWith: aViennaSlicer ]
]
