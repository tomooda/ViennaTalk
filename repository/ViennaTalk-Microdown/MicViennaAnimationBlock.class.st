Class {
	#name : 'MicViennaAnimationBlock',
	#superclass : 'MicViennaBlock',
	#instVars : [
		'prestate',
		'poststate'
	],
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

	| bodyNode receiver script result |
	resultString := nil.
	errorString := nil.
	bodyNode := self bodyNode ifNil: [ ^ errorString := 'Syntax error in the body' ].
	receiver := self transpiledReceiver.
	prestate := self ifShowNoState: [ nil ] otherwise: [ receiver _state ].
	script := ViennaVDM2SmalltalkObject new generate: bodyNode env: (receiver ifNotNil: #_viennaEnv ifNil: [ Dictionary new ]).
	result := [
		          OpalCompiler new
			          source: script;
			          logged: false;
			          receiver: receiver;
			          evaluate ]
		          on: Exception
		          do: [ :ex | ^ errorString := ex messageText ].
	poststate := self ifShowNoState: [ nil ] otherwise: [ receiver _state ].
	self
		ifShowDiffState: [
				poststate ifNotNil: [
						poststate keys do: [ :var |
								prestate at: var ifPresent: [ :pre |
										pre = (poststate at: var) ifTrue: [
												prestate removeKey: var.
												poststate removeKey: var ] ] ] ] ]
		otherwise: [ ].
	resultString := self
		                ifShowNoState: [
				                String streamContents: [ :stream |
						                stream
							                nextPutAll: self body asString trim;
							                nextPutAll: ' → '.
						                result viennaStringOn: stream ] ]
		                otherwise: [
				                String streamContents: [ :stream |
						                self printState: prestate on: stream.
						                stream
							                space;
							                nextPutAll: self body asString trim;
							                nextPutAll: ' → '.
						                result viennaStringOn: stream.
						                stream space.
						                self printState: poststate on: stream ] ]
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
							nextPutAll: assoc value viennaString ]
				separatedBy: [ aStream nextPutAll: ', ' ].
			aStream nextPutAll: '}' ]
]

{ #category : 'accessing' }
MicViennaAnimationBlock >> state [

	^ arguments at: #state ifAbsent: [ nil ]
]
