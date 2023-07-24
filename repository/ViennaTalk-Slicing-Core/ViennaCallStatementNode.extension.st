Extension { #name : #ViennaCallStatementNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaCallStatementNode >> sliceWith: aViennaSlicer [

	aViennaSlicer call: self name.
	self expressionList reverseDo: [ :expression |
		expression sliceWith: aViennaSlicer ]
]
