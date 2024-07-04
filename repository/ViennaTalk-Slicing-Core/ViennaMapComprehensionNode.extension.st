Extension { #name : 'ViennaMapComprehensionNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaMapComprehensionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self keyExpression;
			read: self valueExpression;
			read: self suchthatExpression.
		self bindList do: [ :bind | aViennaSlicer read: bind ] ].
	[
	| origin |
	origin := aViennaSlicer copy.
	self valueExpression sliceWith: aViennaSlicer.
	self keyExpression sliceWith: aViennaSlicer.
	self suchthatExpression ifNotNil: [:suchthat | suchthat sliceWith: aViennaSlicer].
	aViennaSlicer agenda ~= origin agenda ] whileTrue.

	self bindList do: [ :bind | bind sliceWith: aViennaSlicer ]
]
