Extension { #name : 'ViennaTypeJudgementNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaTypeJudgementNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression;
			read: self type ].
	self type sliceWith: aViennaSlicer.
	self expression sliceWith: aViennaSlicer
]
