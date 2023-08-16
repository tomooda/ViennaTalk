Extension { #name : #ViennaSequenceComprehensionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaSequenceComprehensionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression;
			read: self suchthatExpression;
			read: self setSeqBind ].
	[
	| origin |
	origin := aViennaSlicer copy.
	self expression sliceWith: aViennaSlicer.
	self suchthatExpression sliceWith: aViennaSlicer.
	aViennaSlicer agenda ~= origin agenda ] whileTrue.
	self setSeqBind sliceWith: aViennaSlicer
]
