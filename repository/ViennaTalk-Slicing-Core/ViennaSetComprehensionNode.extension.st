Extension { #name : 'ViennaSetComprehensionNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaSetComprehensionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression;
			read: self suchthatExpression.
		self bindList do: [ :bind | aViennaSlicer read: bind ] ].
	[
	| origin |
	origin := aViennaSlicer copy.
	self expression sliceWith: aViennaSlicer.
	self suchthatExpression ifNotNil: [ :node |
		node sliceWith: aViennaSlicer ].
	aViennaSlicer agenda ~= origin agenda ] whileTrue.
	self bindList reverseDo: [ :bind | bind sliceWith: aViennaSlicer ]
]
