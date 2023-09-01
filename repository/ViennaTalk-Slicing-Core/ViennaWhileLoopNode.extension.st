Extension { #name : #ViennaWhileLoopNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaWhileLoopNode >> sliceWith: aViennaSlicer [

	[
	| origin |
	origin := aViennaSlicer copy.
	aViennaSlicer branch
		value: [ :subslicer | self expression sliceWith: subslicer ];
		value: [ :subslicer |
			| localOrigin |
			localOrigin := subslicer copy.
			self statement sliceWith: subslicer.
			localOrigin agenda ~= subslicer agenda ifTrue: [
					subslicer control: self expression ].
			self expression sliceWith: subslicer ];
		value: nil.
	aViennaSlicer agenda ~= origin agenda ] whileTrue
]
