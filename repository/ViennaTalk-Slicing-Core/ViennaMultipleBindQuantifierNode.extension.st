Extension { #name : #ViennaMultipleBindQuantifierNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaMultipleBindQuantifierNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression.
		self bindList do: [ :bind | aViennaSlicer read: bind ] ].
	[
	| origin |
	origin := aViennaSlicer copy.
	self expression sliceWith: aViennaSlicer.
	aViennaSlicer agenda ~= origin agenda ] whileTrue.
	self bindList do: [ :bind | bind sliceWith: aViennaSlicer ]
]
