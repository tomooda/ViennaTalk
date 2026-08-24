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

	| bodyNode animation prestate |
	resultString := nil.
	errorString := nil.
	bodyNode := self bodyNode ifNil: [ ^ self syntaxError ].
	animation := self animation.
	prestate := animation state.
	animation
		execute: bodyNode
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
MicViennaAnimationBlock >> printState: aDictionary [

	^ String streamContents: [ :stream | self printState: aDictionary on: stream ]
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
							nextPutAll: assoc value ]
				separatedBy: [ aStream nextPutAll: ', ' ].
			aStream nextPutAll: '}' ]
]

{ #category : 'accessing' }
MicViennaAnimationBlock >> resultString: aString prestate: aDictionary poststate: anotherDictionary [

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
				                String streamContents: [ :stream |
						                stream
							                nextPutAll: self body asString trim;
							                nextPutAll: ' → ';
							                nextPutAll: aString ] ]
		                otherwise: [
				                String streamContents: [ :stream |
						                self printState: aDictionary on: stream.
						                stream
							                space;
							                nextPutAll: self body asString trim;
							                nextPutAll: ' → ';
							                nextPutAll: aString;
							                space.
						                self printState: anotherDictionary on: stream ] ]
]

{ #category : 'accessing' }
MicViennaAnimationBlock >> state [

	^ arguments at: #state ifAbsent: [ nil ]
]
