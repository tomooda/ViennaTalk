Extension { #name : 'ViennaTypeJudgementNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaTypeJudgementNode >> sliceWith: aViennaSlicer [

	| inv |
	inv := self type resolve inv.
	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression;
			read: self type.
		inv ifNotNil: [ aViennaSlicer read: inv ] ].
	self type sliceWith: aViennaSlicer.
	inv ifNotNil: [ inv sliceWith: aViennaSlicer ].
	self expression sliceWith: aViennaSlicer
]
