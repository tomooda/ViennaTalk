Extension { #name : #ViennaSetForLoopNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaSetForLoopNode >> sliceWith: aViennaSlicer [

	| needsControl |
	needsControl := false.
	[
	| origin |
	origin := aViennaSlicer copy.
	aViennaSlicer branch
		value: [ :subslicer | subslicer ];
		value: [ :subslicer |
			self statement sliceWith: subslicer.
			subslicer onNode: self do: [  ] ];
		value: nil.
	aViennaSlicer agenda ~= origin agenda ] whileTrue: [
		needsControl := true ].
	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self pattern.
		aViennaSlicer read: self expression ].
	needsControl ifTrue: [ aViennaSlicer control: self expression ].
	self pattern sliceWith: aViennaSlicer.
	self expression sliceWith: aViennaSlicer
]
