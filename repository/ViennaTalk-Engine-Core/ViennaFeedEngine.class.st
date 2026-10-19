Class {
	#name : 'ViennaFeedEngine',
	#superclass : 'ViennaEngine',
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

{ #category : 'evaluating' }
ViennaFeedEngine >> evaluate: expression specification: specification states: states module: moduleName [

	| request response |
	request := Dictionary new.
	states keysAndValuesDo: [ :module :binds | binds keysAndValuesDo: [ :var :value | request at: module , '`' , var put: value ] ].
	request at: 'source' put: specification.
	request at: 'expression' put: expression.
	request at: 'module' put: moduleName.
	response := self taskClass new value: request.
	^ Array
		  with: ((response at: 'message') ifEmpty: [ response at: 'value' ] ifNotEmpty: [ nil ])
		  with: (self stateFromJson: response)
		  with: (response at: 'message')
		  with: (response at: 'prestates' ifAbsent: [ Dictionary new ])
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

{ #category : 'class access' }
ViennaFeedEngine >> taskClass [

	^ ViennaFeedTask
]
