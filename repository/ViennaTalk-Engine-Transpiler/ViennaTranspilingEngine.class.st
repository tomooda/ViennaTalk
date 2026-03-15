Class {
	#name : 'ViennaTranspilingEngine',
	#superclass : 'ViennaEngine',
	#category : 'ViennaTalk-Engine-Transpiler',
	#package : 'ViennaTalk-Engine-Transpiler'
}

{ #category : 'defaults' }
ViennaTranspilingEngine class >> default [

	^ self new
]

{ #category : 'accessing' }
ViennaTranspilingEngine class >> engineType [

	^ #Transpiler
]

{ #category : 'accessing' }
ViennaTranspilingEngine class >> priority [

	^ 10
]

{ #category : 'accessing' }
ViennaTranspilingEngine >> animation [

	^ self animationClass new
]

{ #category : 'class access' }
ViennaTranspilingEngine >> animationClass [

	^ ViennaTranspiledAnimation
]

{ #category : 'accessing' }
ViennaTranspilingEngine >> close [

	
]

{ #category : 'evaluating' }
ViennaTranspilingEngine >> evaluate: expression specification: specification states: states module: module [

	| animation preStates result postStates |
	animation := self animationClass new.
	animation specification: specification ifError: [ :msg |
			^ {
				  nil.
				  states.
				  msg.
				  states } ].
	preStates := Dictionary new.
	states keysAndValuesDo: [ :moduleName :binds |
			binds keysAndValuesDo: [ :shortName :value |
				animation plainAt: moduleName , '`' , shortName put: value ] ].
	result := animation
		          plainEvaluate: expression
		          in: module
		          ifError: [ :msg |
				          ^ {
					            nil.
					            states.
					            msg.
					            states } ].
	postStates := Dictionary new.
	animation state keysAndValuesDo: [ :globalName :value |
			(globalName substrings: '`') ifNotEmpty: [ :pair |
					| moduleName shortName |
					moduleName := pair first.
					shortName := pair second.
					(postStates at: moduleName ifAbsentPut: [ Dictionary new ])
						at: shortName
						put: value ] ].
	^ {
		  result.
		  postStates.
		  String new.
		  states }
]
