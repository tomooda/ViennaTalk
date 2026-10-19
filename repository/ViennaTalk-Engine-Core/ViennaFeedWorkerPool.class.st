Class {
	#name : 'ViennaFeedWorkerPool',
	#superclass : 'FedJsonWorkerPool',
	#instVars : [
		'engine'
	],
	#category : 'ViennaTalk-Engine-Core',
	#package : 'ViennaTalk-Engine-Core'
}

{ #category : 'accessing' }
ViennaFeedWorkerPool class >> commandName [
	"My subclasses may override this method to define its own command name."

	^ 'feed'
]

{ #category : 'commandline' }
ViennaFeedWorkerPool class >> feed [

	<commandline>
	^ self commandSpec
]

{ #category : 'accessing' }
ViennaFeedWorkerPool class >> poolDirectory [

	^ FileLocator viennaTalkDirectory / 'FeedPool'
]

{ #category : 'defaults' }
ViennaFeedWorkerPool >> defaultEngine [

	^ ViennaTranspilingEngine default
]

{ #category : 'execution' }
ViennaFeedWorkerPool >> evaluate: aString specification: anotherString states: aDictionary module: yetAnotherString [

	^ engine
		  evaluate: aString
		  specification: anotherString
		  states: aDictionary
		  module: yetAnotherString
]

{ #category : 'initialization' }
ViennaFeedWorkerPool >> initialize [

	super initialize.
	engine := self defaultEngine
]

{ #category : 'execution' }
ViennaFeedWorkerPool >> process: aRequestJson [

	| source expression preStates module result responseJson |
	source := aRequestJson at: 'source' ifAbsent: [ String new ].
	expression := aRequestJson at: 'expression' ifAbsent: [ String new ].
	preStates := Dictionary new: aRequestJson size.
	aRequestJson keysAndValuesDo: [ :key :value |
			(key includes: $`) ifTrue: [
					| index moduleName var |
					index := key indexOf: $`.
					moduleName := key copyFrom: 1 to: index - 1.
					var := key copyFrom: index + 1 to: key size.
					(preStates at: moduleName ifAbsentPut: [ Dictionary new ]) at: var put: value ] ].
	module := aRequestJson at: 'module' ifAbsent: [ 'DEFAULT' ].
	result := self
		          evaluate: expression
		          specification: source
		          states: preStates
		          module: module.
	responseJson := Dictionary new.
	responseJson
		at: 'source' put: source;
		at: 'expression' put: expression;
		at: 'value' put: (result first ifNil: [ String new ]);
		at: 'message' put: result third.
	result second keysAndValuesDo: [ :moduleName :bindings |
		bindings keysAndValuesDo: [ :varName :value | responseJson at: moduleName , '`' , varName put: value ] ].
	^ responseJson
]
