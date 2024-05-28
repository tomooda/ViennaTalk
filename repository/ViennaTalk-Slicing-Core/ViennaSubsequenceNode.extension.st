Extension { #name : 'ViennaSubsequenceNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaSubsequenceNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self sequenceExpression;
			read: self startExpression;
			read: self endExpression ].
	self endExpression sliceWith: aViennaSlicer.
	self startExpression sliceWith: aViennaSlicer.
	self sequenceExpression sliceWith: aViennaSlicer
]
