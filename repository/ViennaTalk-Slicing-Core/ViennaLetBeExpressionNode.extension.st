Extension { #name : #ViennaLetBeExpressionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaLetBeExpressionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression ].
	self expression sliceWith: aViennaSlicer.
	aViennaSlicer onNode: self multipleBind do: [
		aViennaSlicer write: self multipleBind.
		aViennaSlicer read: self conditionExpression.
		aViennaSlicer read: self multipleBind ].
	[
	| origin |
	origin := aViennaSlicer copy.
	self conditionExpression sliceWith: aViennaSlicer.
	aViennaSlicer agenda ~= origin agenda ] whileTrue.
	self multipleBind sliceWith: aViennaSlicer
]
