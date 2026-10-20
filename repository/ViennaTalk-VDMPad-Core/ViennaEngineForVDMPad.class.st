Class {
	#name : 'ViennaEngineForVDMPad',
	#superclass : 'ViennaTranspilingEngine',
	#category : 'ViennaTalk-VDMPad-Core-Engine',
	#package : 'ViennaTalk-VDMPad-Core',
	#tag : 'Engine'
}

{ #category : 'accessing' }
ViennaEngineForVDMPad class >> engineType [

	^ nil
]

{ #category : 'accessing' }
ViennaEngineForVDMPad class >> priority [

	^ -1
]

{ #category : 'class access' }
ViennaEngineForVDMPad >> animationClass [

	^ ViennaAnimationForVDMPad
]

{ #category : 'utilities' }
ViennaEngineForVDMPad >> charPositionToPoint: anInteger in: aString [
	| toGo numLines |
	toGo := anInteger + 1.
	numLines := 1.
	aString
		linesDo: [ :line | 
			| numChars |
			numChars := line size + 1.
			toGo <= numChars
				ifTrue: [ ^ toGo @ numLines ].
			toGo := toGo - numChars.
			numLines := numLines + 1 ].
	^ toGo @ numLines
]

{ #category : 'evaluating' }
ViennaEngineForVDMPad >> evaluate: expression specification: specification states: states module: moduleOrNil executionTrace: diagramNames [

	| parser valueReader documentNode module expressionNode transpiledSpec prestates poststates result diagrams json |
	parser := ViennaVDMParser new.
	valueReader := ViennaReader new.
	documentNode := parser document end parse: specification withContext: ViennaPP2HighlightingContext new.
	documentNode isPetit2Failure ifTrue: [
			| position point |
			position := documentNode furthestPosition.
			point := self charPositionToPoint: position in: specification.
			^ self message: 'Syntax error in the specification at ' , point y printString , ':' , point x printString , '.' states: states ].
	documentNode := documentNode returnValue asModularDocument.
	[ documentNode typecheck ]
		on: ViennaTypeError
		do: [ :typeError | ^ self message: typeError messageText states: states ].
	module := moduleOrNil = 'DEFAULT'
		          ifTrue: [ nil ]
		          ifFalse: [ moduleOrNil ].
	(module notNil and: [ (documentNode moduleNamed: module) isNil ]) ifTrue: [
		^ self message: 'Unknown module: ' , module states: states ].
	transpiledSpec := self transpilerClass new generate: documentNode.
	expressionNode := expression
		                  ifNotEmpty: [ :string |
		                  parser statement / parser expression end parse: string withContext: ViennaPP2HighlightingContext new ]
		                  ifEmpty: [ nil ].
	expressionNode isPetit2Failure ifTrue: [
			| position point |
			position := expressionNode furthestPosition.
			point := self charPositionToPoint: position in: expression.
			^ self
				  message: 'Syntax error in the expression/statement at ' , point y printString , ':' , point x printString , '.'
				  states: states ].
	expressionNode := expressionNode ifNotNil: #returnValue.
	prestates := Dictionary new.
	states keysAndValuesDo: [ :moduleName :moduleState |
			transpiledSpec at: moduleName ifPresent: [ :transpiledModule |
					| modulePrestate |
					modulePrestate := Dictionary new.
					prestates at: moduleName put: modulePrestate.
					moduleState keysAndValuesDo: [ :variableName :valueString |
							transpiledModule basicInstVarNamed: variableName put: (valueReader parse: valueString).
							modulePrestate at: variableName put: valueString ] ] ].
	expressionNode ifNotNil: [
			| needsSequenceDiagram needsStateDiagram needsExecutionTrace |
			needsSequenceDiagram := diagramNames includes: 'sequenceDiagram'.
			needsStateDiagram := diagramNames includesKey: 'stateDiagram'.
			needsExecutionTrace := diagramNames notEmpty.
			needsExecutionTrace ifTrue: [
					transpiledSpec useEventRecorder:
						(transpiledSpec state associations collect: [ :assoc | assoc key -> assoc value asOrderedDictionary ]) asOrderedDictionary ].





			result := [
				          (transpiledSpec at: module ifAbsent: [ transpiledSpec ]) evaluateNode: expressionNode ifError: [ :msg |
						          json at: 'message' put: 'Runtime error: ' , msg.
						          self ] ]
				          on: Exception
				          do: [ :ex |
						          json
							          at: 'message'
							          put: 'Runtime error: ' , ex class name , ((ex signalContext specificationContext ifNotNil: #vdmPcNodes)
									           ifNotNil: [ :nodes |
									           String lf , (String lf , '↖' , String lf join: (nodes select: #notNil thenCollect: #source)) ]
									           ifNil: [ '' ]).
						          ^ self responseJSON: json ].
			needsExecutionTrace ifTrue: [
					transpiledSpec _recorder output ifNotNil: [ :root |
							needsSequenceDiagram ifTrue: [
									| sequenceDiagram |
									sequenceDiagram := String streamContents: [ :stream |
											                   | format |
											                   format := ViennaExecutionTraceSequenceDiagramFormat new
												                             root: expression;
												                             yourself.
											                   format writeHeaderOn: stream.
											                   root applyToFormat: format on: stream.
											                   format writeFooterOn: stream ].
									json at: 'sequenceDiagram' put: sequenceDiagram ].
							needsStateDiagram ifTrue: [
									| stateDiagram |
									stateDiagram := String streamContents: [ :stream |
											                | format |
											                format := ViennaExecutionTraceStateDiagramFormat new
												                          probes: transpiledSpec _defaultProbes;
												                          showsProbeNames: true;
												                          showsOperationNames: true;
												                          yourself.
											                root initial do: [ :event | event applyAssignmentTo: transpiledSpec ].
											                format writeHeaderOn: stream.
											                root
												                applyToFormat: format
												                on: stream
												                before: [ :event | event applyAssignmentTo: transpiledSpec ]
												                after: [ :event |  ].
											                format writeFooterOn: stream ].
									json at: 'stateDiagram' put: stateDiagram ] ] ] ].
	transpiledSpec statevariablesAndValuesDo: [ :var :val | json at: var put: val viennaString ].
	result == self ifFalse: [ json at: 'value' put: result viennaString ].
	^ self responseJSON: json
]

{ #category : 'utilities' }
ViennaEngineForVDMPad >> message: messageString preStates: prestatesDictionary postStates: poststatesDictionary [

	^ self
		  result: nil
		  postStates: poststatesDictionary
		  message: messageString
		  preStates: prestatesDictionary
		  diagrams: Dictionary new
]

{ #category : 'utilities' }
ViennaEngineForVDMPad >> message: messageString states: statesDictionary [

	^ self
		  result: nil
		  postStates: statesDictionary
		  message: messageString
		  preStates: statesDictionary
		  diagrams: Dictionary new
]

{ #category : 'utilities' }
ViennaEngineForVDMPad >> result: resultString postStates: poststatesDictionary message: messageString preStates: prestatesDictionary diagrams: yetAnotherDictionary [

	^ {
		  resultString.
		  poststatesDictionary.
		  messageString.
		  prestatesDictionary.
		  yetAnotherDictionary }
]

{ #category : 'utilities' }
ViennaEngineForVDMPad >> result: resultString preStates: prestatesDictionary postStates: poststatesDictionary diagrams: yetAnotherDictionary [

	^ self
		  result: resultString
		  postStates: poststatesDictionary
		  message: nil
		  preStates: prestatesDictionary
		  diagrams: yetAnotherDictionary
]

{ #category : 'class access' }
ViennaEngineForVDMPad >> transpilerClass [

	^ ViennaTranspilerForVDMPad
]
