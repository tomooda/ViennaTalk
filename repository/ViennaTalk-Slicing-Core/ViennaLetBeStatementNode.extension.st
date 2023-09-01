Extension { #name : #ViennaLetBeStatementNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaLetBeStatementNode >> sliceWith: aViennaSlicer [

	self statement sliceWith: aViennaSlicer.
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
