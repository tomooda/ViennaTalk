Class {
	#name : #ViennaTranspilingEngine,
	#superclass : #ViennaEngine,
	#category : #'ViennaTalk-Transpiler-Core'
}

{ #category : #accessing }
ViennaTranspilingEngine >> close [

	
]

{ #category : #evaluating }
ViennaTranspilingEngine >> evaluate: expression specification: specification states: states module: module vdm10: vdm10 rtc: rtc [

	| animation preStates result postStates |
	animation := ViennaTranspiledAnimation new.
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
