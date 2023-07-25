Extension { #name : #ViennaCallStatementNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaCallStatementNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [ aViennaSlicer call: self name ].
	self expressionList reverseDo: [ :expression |
		expression sliceWith: aViennaSlicer ]
]
