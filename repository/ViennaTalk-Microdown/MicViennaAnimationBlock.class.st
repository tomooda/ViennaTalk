Class {
	#name : 'MicViennaAnimationBlock',
	#superclass : 'MicViennaBlock',
	#category : 'ViennaTalk-Microdown-Microdown',
	#package : 'ViennaTalk-Microdown',
	#tag : 'Microdown'
}

{ #category : 'testing' }
MicViennaAnimationBlock class >> isAbstract [

	^ self == MicViennaAnimationBlock
]

{ #category : 'defaults' }
MicViennaAnimationBlock >> defaultState [

	^ #diff
]

{ #category : 'executing' }
MicViennaAnimationBlock >> execute [

	| animation prestate |
	resultString := nil.
	errorString := nil.
	self bodyNode ifNil: [ ^ self syntaxError ].
	animation := self animation.
	prestate := animation state.
	animation
		execute: self bodyNode
		in: self moduleName
		do: [ :result :poststate | self resultString: result viennaString prestate: prestate poststate: poststate ]
		ifError: [ :message | ^ self errorString: message ]
]

{ #category : 'controlling' }
MicViennaAnimationBlock >> ifShowDiffState: diffShowBlock otherwise: aBlock [

	^ self ifShowFullState: aBlock ifDiffState: diffShowBlock ifNoState: aBlock
]

{ #category : 'controlling' }
MicViennaAnimationBlock >> ifShowFullState: fullShowBlock ifDiffState: diffShowBlock ifNoState: noShowBlock [

	| state |
	state := self state.
	(#( all diff no ) includes: state) ifFalse: [ state := self defaultState ].
	state = #all ifTrue: [ ^ fullShowBlock value ].
	state = #diff ifTrue: [ ^ diffShowBlock value ].
	state = #no ifTrue: [ ^ noShowBlock value ].
	^ nil
]

{ #category : 'controlling' }
MicViennaAnimationBlock >> ifShowNoState: noShowBlock otherwise: aBlock [

	^ self ifShowFullState: aBlock ifDiffState: aBlock ifNoState: noShowBlock
]

{ #category : 'printing' }
MicViennaAnimationBlock >> printState: aDictionary on: aStream [

	aDictionary ifNotNil: [
			aStream nextPutAll: '{'.
			aDictionary associations
				do: [ :assoc |
						aStream
							nextPutAll: assoc key;
							nextPutAll: '=';
							nextPutAll: (self vdmHighlight: assoc value parent: self bodyNode parent) ]
				separatedBy: [ aStream nextPutAll: ', ' ].
			aStream nextPutAll: '}' ]
]

{ #category : 'accessing' }
MicViennaAnimationBlock >> resultString: aString prestate: aDictionary poststate: anotherDictionary [

	| result |
	result := self vdmHighlight: aString parent: self bodyNode parent.
	self
		ifShowDiffState: [
				anotherDictionary ifNotNil: [
						anotherDictionary keys do: [ :var |
								aDictionary at: var ifPresent: [ :pre |
										pre = (anotherDictionary at: var) ifTrue: [
												aDictionary removeKey: var.
												anotherDictionary removeKey: var ] ] ] ] ]
		otherwise: [ ].
	resultString := self
		                ifShowNoState: [
				                Text streamContents: [ :stream |
						                stream
							                nextPutAll: self bodyText;
							                nextPutAll: ' → ';
							                nextPutAll: result ] ]
		                otherwise: [
				                Text streamContents: [ :stream |
						                self printState: aDictionary on: stream.
						                stream
							                space;
							                nextPutAll: self bodyText;
							                nextPutAll: ' → ';
							                nextPutAll: result;
							                space.
						                self printState: anotherDictionary on: stream ] ]
]

{ #category : 'accessing' }
MicViennaAnimationBlock >> state [

	^ arguments at: #state ifAbsent: [ nil ]
]
