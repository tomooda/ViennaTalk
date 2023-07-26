Extension { #name : #ViennaIndexForLoopNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaIndexForLoopNode >> sliceWith: aViennaSlicer [

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
		aViennaSlicer write: self.
		self stepExpression ifNotNil: [ :expression |
			aViennaSlicer read: expression ].
		self endExpression ifNotNil: [ :expression |
			aViennaSlicer read: expression ].
		self startExpression ifNotNil: [ :expression |
			aViennaSlicer read: expression ] ].
	self stepExpression ifNotNil: [ :expression |
		needsControl ifTrue: [ aViennaSlicer control: expression ].
		expression sliceWith: aViennaSlicer ].
	self endExpression ifNotNil: [ :expression |
		needsControl ifTrue: [ aViennaSlicer control: expression ].
		expression sliceWith: aViennaSlicer ].
	self startExpression ifNotNil: [ :expression |
		needsControl ifTrue: [ aViennaSlicer control: expression ].
		expression sliceWith: aViennaSlicer ]
]
