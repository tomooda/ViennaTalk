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
VDMPadWorkerPool >> process: requestJson [

	requestJson at: 'api' ifPresent: [ :api | api = 'eval' ifTrue: [ ^ self eval: requestJson ] ].
	^ nil
]

{ #category : 'class access' }
VDMPadWorkerPool >> transpilerClass [

	^ ViennaTranspilerForVDMPad
]
