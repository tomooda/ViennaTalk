Extension { #name : #ViennaDclStatementNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaDclStatementNode >> sliceWith: aViennaSlicer [

	self reverseDo: [ :assignmentDefinition |
		assignmentDefinition sliceWith: aViennaSlicer ]
]
