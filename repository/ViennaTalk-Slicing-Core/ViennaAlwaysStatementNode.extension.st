Extension { #name : #ViennaAlwaysStatementNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaAlwaysStatementNode >> sliceWith: aViennaSlicer [

	self entailingStatement sliceWith: aViennaSlicer.
	self bodyStatement sliceWith: aViennaSlicer
]
