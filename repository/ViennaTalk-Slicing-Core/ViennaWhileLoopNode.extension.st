Extension { #name : #ViennaWhileLoopNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaWhileLoopNode >> sliceWith: aViennaSlicer [

	self expression sliceWith: aViennaSlicer.
	[
	| origin |
	origin := aViennaSlicer copy.
	aViennaSlicer branch
		value: [ :subslicer | subslicer ];
		value: [ :subslicer |
			self statement sliceWith: subslicer.
			self expression sliceWith: subslicer ];
		value: nil.
	aViennaSlicer agenda = origin agenda ] whileFalse
]
