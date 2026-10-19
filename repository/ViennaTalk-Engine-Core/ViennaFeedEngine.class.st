Class {
	#name : 'ViennaFeedEngine',
	#superclass : 'ViennaEngine',
	#instVars : [
		'pollingInterval'
	],
	#category : 'ViennaTalk-Engine-Core',
	#package : 'ViennaTalk-Engine-Core'
}

{ #category : 'accessing' }
ViennaFeedEngine class >> engineType [

	^ #FEED
]

{ #category : 'accessing' }
ViennaFeedEngine class >> priority [

	^ 5
]

{ #category : 'accessing' }
ViennaFeedEngine >> close [

	
]

{ #category : 'defaults' }
ViennaFeedEngine >> defaultPollingInterval [

	^ 100 milliSeconds
]

{ #category : 'evaluating' }
ViennaFeedEngine >> evaluate: expression specification: specification states: states module: moduleName [

	| request response id |
	request := Dictionary new.
	states keysAndValuesDo: [ :module :binds | binds keysAndValuesDo: [ :var :value | request at: module , '`' , var put: value ] ].
	request at: 'source' put: specification.
	request at: 'expression' put: expression.
	request at: 'module' put: moduleName.
	id := self request: request.
	response := self response: id.
	^ Array
		  with: ((response at: 'message') ifEmpty: [ response at: 'value' ] ifNotEmpty: [ nil ])
		  with: (self stateFromJson: response)
		  with: (response at: 'message')
		  with: (response at: 'prestates' ifAbsent: [ Dictionary new ])
]

{ #category : 'initialization' }
ViennaFeedEngine >> initialize [

	super initialize.
	pollingInterval := self defaultPollingInterval
]

{ #category : 'accessing' }
ViennaFeedEngine >> pollingInterval [

	^ pollingInterval
]

{ #category : 'accessing' }
ViennaFeedEngine >> pollingInterval: anObject [

	pollingInterval := anObject
]

{ #category : 'accessing' }
ViennaFeedEngine >> poolDirectory [

	^ ViennaFeedApplication poolDirectory
]

{ #category : 'reading-writing' }
ViennaFeedEngine >> request: aDictionary [

	| id tmp |
	[
		id := self poolDirectory / UUID new asInteger asString.
		id exists ] whileTrue.

	id ensureCreateFile.
	tmp := ViennaFeedApplication withRequestExtension: id.
	[
		([ id renameTo: tmp basename ]
			 on: FileExists
			 do: [ :ex | ex return: nil ]) isNil ] whileTrue: [
		tmp := ViennaFeedApplication withRequestExtension: self poolDirectory / UUID new asInteger asString ].
	id writeStreamDo: [ :stream | STONJSON put: aDictionary onStream: stream ].
	^ id withoutExtension
]

{ #category : 'reading-writing' }
ViennaFeedEngine >> response: aFileReference [

	| id json |
	id := ViennaFeedApplication withResponseExtension: aFileReference.
	[ id isFile ] whileFalse: [ self wait ].
	json := id readStreamDo: [ :stream | STONJSON fromStream: stream ].
	id ensureDelete.
	(ViennaFeedApplication withRequestExtension: id) ensureDelete.
	(ViennaFeedApplication withInprogressExtension: id) ensureDelete.
	^ json
]

{ #category : 'private' }
ViennaFeedEngine >> stateFromJson: aDictionary [

	| states |
	states := Dictionary new.
	aDictionary keysAndValuesDo: [ :key :value |
			(key includes: $`) ifTrue: [
					| index module var |
					index := key indexOf: $`.
					module := key copyFrom: 1 to: index - 1.
					var := key copyFrom: index + 1 to: key size.
					(states at: module ifAbsentPut: [ Dictionary new ]) at: var put: value ] ].
	^ states
]

{ #category : 'waiting' }
ViennaFeedEngine >> wait [

	pollingInterval ifNotNil: #wait
]
