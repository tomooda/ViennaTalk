Trait {
	#name : 'TViennaEngine',
	#instVars : [
		'parser',
		'valueReader'
	],
	#category : 'ViennaTalk-Engine-Core',
	#package : 'ViennaTalk-Engine-Core'
}

{ #category : 'parsing' }
TViennaEngine >> charPositionToPoint: anInteger in: aString [
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

{ #category : 'utilities' }
TViennaEngine >> diagram: aString fromResult: anArray ifPresent: presentBlock ifAbsent: absentBlock [

	^ anArray size >= 5
		  ifTrue: [ anArray fifth at: aString ifPresent: presentBlock ifAbsent: absentBlock ]
		  ifFalse: [ absentBlock value ]
]

{ #category : 'parsing' }
TViennaEngine >> diagrams: anArrayOfString from: aViennaTranspiledModularDocument expression: aString [

	| diagrams |
	diagrams := Dictionary new.
	anArrayOfString ifNotEmpty: [
			aViennaTranspiledModularDocument _recorder output ifNotNil: [ :root |
					(anArrayOfString includes: 'sequenceDiagram') ifTrue: [
							| sequenceDiagram |
							sequenceDiagram := String streamContents: [ :stream |
									                   | format |
									                   format := ViennaExecutionTraceSequenceDiagramFormat new
										                             root: aString;
										                             yourself.
									                   format writeHeaderOn: stream.
									                   root applyToFormat: format on: stream.
									                   format writeFooterOn: stream ].
							diagrams at: 'sequenceDiagram' put: sequenceDiagram ].
					(anArrayOfString includes: 'stateDiagram') ifTrue: [
							| stateDiagram |
							stateDiagram := String streamContents: [ :stream |
									                | format |
									                format := ViennaExecutionTraceStateDiagramFormat new
										                          probes: aViennaTranspiledModularDocument _defaultProbes;
										                          showsProbeNames: true;
										                          showsOperationNames: true;
										                          yourself.
									                root initial do: [ :event | event applyAssignmentTo: aViennaTranspiledModularDocument ].
									                format writeHeaderOn: stream.
									                root
										                applyToFormat: format
										                on: stream
										                before: [ :event | event applyAssignmentTo: aViennaTranspiledModularDocument ]
										                after: [ :event |  ].
									                format writeFooterOn: stream ].
							diagrams at: 'stateDiagram' put: stateDiagram ] ] ].
	^ diagrams
]

{ #category : 'parsing' }
TViennaEngine >> documentNodeFrom: specification ifError: errorBlock [

	| parseResult |
	parseResult := self parser document end parse: specification withContext: ViennaPP2HighlightingContext new.
	parseResult isPetit2Failure ifTrue: [
			| position point |
			position := parseResult furthestPosition.
			point := self charPositionToPoint: position in: specification.
			^ errorBlock
				  cull: 'Syntax error in the specification at ' , point y printString , ':' , point x printString , '.'
				  cull: position ].
	^ parseResult returnValue
]

{ #category : 'evaluating' }
TViennaEngine >> ensureModule: moduleOrNil documentNode: documentNode ifError: errorBlock [

	| module |
	module := moduleOrNil = 'DEFAULT'
		          ifTrue: [ nil ]
		          ifFalse: [ moduleOrNil ].
	(module notNil and: [ (documentNode moduleNamed: module) isNil ]) ifTrue: [ ^ errorBlock value: 'Unknown module: ' , module ].
	^ module
]

{ #category : 'evaluating' }
TViennaEngine >> evaluate: expressionNode in: transpiledSpec ifError: errorBlock [

	^ [ transpiledSpec evaluateNode: expressionNode ifError: [ :msg | errorBlock value: 'Runtime error: ' , msg ] ]
		  on: Exception
		  do: [ :ex |
				  ex return:
					  (errorBlock value: 'Runtime error: ' , ex class name , ((ex signalContext specificationContext ifNotNil: #vdmPcNodes)
							    ifNotNil: [ :nodes | String lf , (String lf , '↖' , String lf join: (nodes select: #notNil thenCollect: #source)) ]
							    ifNil: [ '' ])) ]
]

{ #category : 'evaluating' }
TViennaEngine >> evaluate: expression specification: specification states: states module: moduleOrNil [

	^ self
		  evaluate: expression
		  specification: specification
		  states: states
		  module: moduleOrNil
		  diagrams: #(  )
]

{ #category : 'evaluating' }
TViennaEngine >> evaluate: expression specification: specification states: states module: moduleOrNil diagrams: diagramNames [

	| documentNode module expressionNode transpiledSpec prestates result |
	documentNode := (self documentNodeFrom: specification ifError: [ :msg | ^ self message: msg states: states ]) asModularDocument.
	self typecheck: documentNode ifError: [ :msg | ^ self message: msg states: states ].
	transpiledSpec := self transpilerClass new generate: documentNode.
	prestates := self states: states to: transpiledSpec.
	module := self ensureModule: moduleOrNil documentNode: documentNode ifError: [ :msg | ^ self message: msg states: prestates ].
	diagramNames ifNotEmpty: [ self setupExecutionTrace: transpiledSpec ].
	expressionNode := self expressionNodeFrom: expression ifError: [ :msg | ^ self message: msg states: states ].
	result := expressionNode ifNotNil: [
			          self
				          evaluate: expressionNode
				          in: (transpiledSpec at: module ifAbsent: [ transpiledSpec ])
				          ifError: [ :msg |
				          ^ self message: 'Runtime error: ' , msg preStates: prestates postStates: (self statesFrom: transpiledSpec) ] ].
	^ self
		  result: result viennaString
		  preStates: prestates
		  postStates: (self statesFrom: transpiledSpec)
		  diagrams:
		  (expressionNode
			   ifNotNil: [ self diagrams: diagramNames from: transpiledSpec expression: expression ]
			   ifNil: [ Dictionary new ])
]

{ #category : 'parsing' }
TViennaEngine >> expressionNodeFrom: expression ifError: errorBlock [

	| parseResult |
	parseResult := expression
		               ifNotEmpty: [ :string |
		               (self parser statement / self parser expression) end parse: string withContext: ViennaPP2HighlightingContext new ]
		               ifEmpty: [ nil ].
	parseResult isPetit2Failure ifTrue: [
			| position point |
			position := parseResult furthestPosition.
			point := self charPositionToPoint: position in: expression.
			^ errorBlock value: 'Syntax error in the expression/statement at ' , point y printString , ':' , point x printString , '.' ].
	^ parseResult ifNotNil: #returnValue
]

{ #category : 'parsing' }
TViennaEngine >> message: messageString preStates: prestatesDictionary postStates: poststatesDictionary [

	^ self
		  result: nil
		  postStates: poststatesDictionary
		  message: messageString
		  preStates: prestatesDictionary
		  diagrams: Dictionary new
]

{ #category : 'parsing' }
TViennaEngine >> message: messageString states: statesDictionary [

	^ self
		  result: nil
		  postStates: statesDictionary
		  message: messageString
		  preStates: statesDictionary
		  diagrams: Dictionary new
]

{ #category : 'utilities' }
TViennaEngine >> messageFromResult: anArray [

	^ anArray third
]

{ #category : 'accessing' }
TViennaEngine >> parser [

	^ parser ifNil: [ parser := ViennaVDMParser new ]
]

{ #category : 'utilities' }
TViennaEngine >> poststatesFromResult: anArray [

	^ anArray second
]

{ #category : 'utilities' }
TViennaEngine >> prestatesFromResult: anArray [

	^ anArray fourth
]

{ #category : 'parsing' }
TViennaEngine >> result: resultString postStates: poststatesDictionary message: messageString preStates: prestatesDictionary diagrams: yetAnotherDictionary [

	^ {
		  resultString.
		  poststatesDictionary.
		  messageString.
		  prestatesDictionary.
		  yetAnotherDictionary }
]

{ #category : 'parsing' }
TViennaEngine >> result: resultString preStates: prestatesDictionary postStates: poststatesDictionary diagrams: yetAnotherDictionary [

	^ self
		  result: resultString
		  postStates: poststatesDictionary
		  message: nil
		  preStates: prestatesDictionary
		  diagrams: yetAnotherDictionary
]

{ #category : 'evaluating' }
TViennaEngine >> setupExecutionTrace: transpiledSpec [

	transpiledSpec useEventRecorder:
		(transpiledSpec state associations collect: [ :assoc | assoc key -> assoc value asOrderedDictionary ]) asOrderedDictionary
]

{ #category : 'parsing' }
TViennaEngine >> states: states to: transpiledSpec [

	| prestates |
	prestates := Dictionary new.
	states keysAndValuesDo: [ :moduleName :moduleState |
			transpiledSpec at: moduleName ifPresent: [ :transpiledModule |
					| modulePrestate |
					modulePrestate := Dictionary new.
					prestates at: moduleName put: modulePrestate.
					moduleState keysAndValuesDo: [ :variableName :valueString |
							[
								transpiledModule basicInstVarNamed: variableName put: (self valueReader parse: valueString).
								modulePrestate at: variableName put: valueString ]
								on: InstanceVariableNotFound
								do: [ :ex | ex return: nil ] ] ] ].
	^ prestates
]

{ #category : 'parsing' }
TViennaEngine >> statesFrom: transpiledSpec [

	| states |
	states := Dictionary new.
	transpiledSpec keysAndValuesDo: [ :moduleName :transpiledModule |
			| moduleStates |
			moduleStates := Dictionary new.
			states at: moduleName put: moduleStates.
			transpiledModule _statevariablesAndValuesDo: [ :variableName :value | moduleStates at: variableName put: value viennaString ] ].
	^ states
]

{ #category : 'accessing' }
TViennaEngine >> supportedDiagramNames [

	^ #( 'sequenceDiagram' 'stateDiagram' )
]

{ #category : 'class access' }
TViennaEngine >> transpilerClass [

	^ self subclassResponsibility
]

{ #category : 'evaluating' }
TViennaEngine >> typecheck: documentNode ifError: errorBlock [

	^ [ documentNode typecheck ]
		  on: ViennaTypeError
		  do: [ :typeError | typeError return: (errorBlock value: typeError messageText) ]
]

{ #category : 'utilities' }
TViennaEngine >> valueFromResult: anArray [

	^ anArray first
]

{ #category : 'accessing' }
TViennaEngine >> valueReader [

	^ valueReader ifNil: [ valueReader := ViennaReader new ]
]
