Class {
	#name : 'VDMPadWorkerPool',
	#superclass : 'FedWorkerPool',
	#traits : 'TFedJson + TViennaEngine',
	#classTraits : 'TFedJson classTrait + TViennaEngine classTrait',
	#category : 'ViennaTalk-VDMPad-Core-Feed',
	#package : 'ViennaTalk-VDMPad-Core',
	#tag : 'Feed'
}

{ #category : 'accessing' }
VDMPadWorkerPool class >> commandName [

	^ 'VDMPad-worker'
]

{ #category : 'accessing' }
VDMPadWorkerPool class >> description [

	^ 'Worker process for VDMPad API'
]

{ #category : 'instance creation' }
VDMPadWorkerPool class >> newWorkers: anInteger [

	anInteger timesRepeat: [ self newWorker ]
]

{ #category : 'accessing' }
VDMPadWorkerPool class >> poolDirectory [

	^ FileLocator viennaTalkDirectory / 'VDMPad-pool'
]

{ #category : 'system startup' }
VDMPadWorkerPool class >> registerShutdown [

	SessionManager default registerUserClassNamed: self name
]

{ #category : 'system startup' }
VDMPadWorkerPool class >> shutDown: quitting [

	quitting ifTrue: [ self close ]
]

{ #category : 'system startup' }
VDMPadWorkerPool class >> unregisterShutdown [

	<script>
	SessionManager default unregisterHandler: self name ifAbsent: [ ]
]

{ #category : 'accessing' }
VDMPadWorkerPool class >> worker [

	<commandline>
	^ self commandSpec
]

{ #category : 'execution' }
VDMPadWorkerPool >> eval: requestJson [

	| source states result responseJson |
	source := (requestJson at: 'source' ifAbsent: [ String new ]) trimBoth.
	states := Dictionary new.
	requestJson keysAndValuesDo: [ :key :value |
			((key includes: $`) and: [ value trimBoth notEmpty ]) ifTrue: [
					| moduleName variableName valueString |
					moduleName := key copyFrom: 1 to: (key indexOf: $`) - 1.
					variableName := key copyFrom: (key indexOf: $`) + 1 to: key size.
					valueString := (value withInternalLineEndings copyReplaceAll: String cr with: ' ') trim.
					(states at: moduleName ifAbsentPut: [ Dictionary new ]) at: variableName put: valueString ] ].

	result := self
		          evaluate:
		          ((requestJson at: 'expression' ifAbsent: [ String new ]) withInternalLineEndings copyReplaceAll: String cr with: ' ')
			          trim
		          specification: source
		          states: states
		          module: (requestJson at: 'module' ifAbsent: [ nil ])
		          diagrams: (self supportedDiagramNames select: [ :diagramName | requestJson includesKey: diagramName ]).
	responseJson := Dictionary new.
	responseJson
		at: 'source' put: source;
		at: 'value' put: (self valueFromResult: result);
		at: 'prestates' put: (self prestatesFromResult: result);
		at: 'message' put: (self messageFromResult: result).
	(self poststatesFromResult: result) keysAndValuesDo: [ :module :moduleStates |
		moduleStates keysAndValuesDo: [ :variable :value | responseJson at: module , '`' , variable put: value ] ].
	self supportedDiagramNames do: [ :diagramName |
			self
				diagram: diagramName
				fromResult: result
				ifPresent: [ :diagram | responseJson at: diagramName put: diagram ]
				ifAbsent: [ ] ].
	^ responseJson
]

{ #category : 'execution' }
VDMPadWorkerPool >> format: requestJson [

	| responseJson source ast |
	responseJson := requestJson copy
		        at: 'message' put: '';
		        at: 'value' ifAbsentPut: [ String new ];
		        yourself.
	source := (requestJson at: 'source' ifAbsent: [ String new ]) trim withInternalLineEndings.
	ast := self documentNodeFrom: source ifError: [ :msg :position |
			       responseJson
				       at: 'message' put: msg;
				       at: 'position' put: position.
			       ^ responseJson ].
	responseJson at: 'source' put: (ViennaVDMFormatter new
			 maxSizePerLine: 70;
			 format: ast) withUnixLineEndings.
	^ responseJson
]

{ #category : 'execution' }
VDMPadWorkerPool >> process: requestJson [

	requestJson at: 'api' ifPresent: [ :api |
			api = 'eval' ifTrue: [ ^ self eval: requestJson ].
			api = 'test' ifTrue: [ ^ self test: requestJson ].
			api = 'format' ifTrue: [ ^ self format: requestJson ] ].
	^ nil
]

{ #category : 'execution' }
VDMPadWorkerPool >> test: json [

	| source prestates expression expectedPoststates expectedValue states triple actualValue actualPoststates diff |
	source := json at: 'source'.
	prestates := json at: 'prestates' ifAbsent: [ Dictionary new ].
	expression := ((json at: 'expression' ifAbsent: [ String new ]) copyReplaceAll: String cr with: ' ')
		              copyReplaceAll: String lf
		              with: ' '.
	expectedValue := json at: 'value' ifAbsent: [ ].
	expectedPoststates := json at: 'poststates' ifAbsent: [ ].
	states := Dictionary new.
	prestates keysAndValuesDo: [ :key :value |
			((key includes: $`) and: [ value trim notEmpty ]) ifTrue: [
					(states at: (key copyFrom: 1 to: (key indexOf: $`) - 1) ifAbsentPut: [ Dictionary new ])
						at: (key copyFrom: (key indexOf: $`) + 1 to: key size)
						put: ((value copyReplaceAll: String cr with: ' ') copyReplaceAll: String lf with: ' ') ].
			prestates add: key -> value ].
	triple := self
		          evaluate: expression
		          specification: source
		          states: states
		          module: 'DEFAULT'.
	diff := Array new writeStream.
	actualValue := triple first.
	actualValue ifNil: [ diff nextPut: triple third ] ifNotNil: [
			actualValue ~= expectedValue ifTrue: [ diff nextPut: 'RESUT=' , actualValue , ' (excepted ' , expectedValue , ')' ].
			actualPoststates := Dictionary new.
			triple second keysAndValuesDo: [ :moduleName :bindings |
				bindings keysAndValuesDo: [ :var :val | actualPoststates at: moduleName , '`' , var put: val ] ].
			expectedPoststates keysAndValuesDo: [ :key :value |
					| actual |
					actual := actualPoststates at: key ifAbsent: [ ].
					actual ~= value ifTrue: [ diff nextPut: key , '=' , actual , ' (expected ' , value , ')' ] ] ].
	diff := diff contents.
	^ diff ifEmpty: [ true ] ifNotEmpty: [ diff ]
]

{ #category : 'class access' }
VDMPadWorkerPool >> transpilerClass [

	^ ViennaTranspilerForVDMPad
]
