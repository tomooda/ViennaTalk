Extension { #name : #ViennaSequenceComprehensionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaSequenceComprehensionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression;
			read: self setSeqBind.
		self suchthatExpression ifNotNil: [ :exp | aViennaSlicer read: exp ] ].
	[
	| origin |
	origin := aViennaSlicer copy.
	self expression sliceWith: aViennaSlicer.
	self suchthatExpression ifNotNil: [ :exp |
		exp sliceWith: aViennaSlicer ].
	aViennaSlicer agenda ~= origin agenda ] whileTrue.
	self setSeqBind sliceWith: aViennaSlicer
]
