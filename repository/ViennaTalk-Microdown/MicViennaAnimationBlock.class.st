Class {
	#name : 'MicViennaAnimationBlock',
	#superclass : 'MicViennaBlock',
	#instVars : [
		'diagrams',
		'forms'
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

{ #category : 'accessing' }
MicViennaAnimationBlock >> diagrams [

	^ diagrams ifNil: [
			  diagrams := Array streamContents: [ :stream |
					              arguments
						              at: #diagrams
						              ifPresent: [ :string | stream nextPutAll: ((string substrings: ',') collect: #trim thenSelect: #notEmpty) ];
						              at: #diagram
						              ifPresent: [ :string | stream nextPutAll: ((string substrings: ',') collect: #trim thenSelect: #notEmpty) ] ] ]
]

{ #category : 'executing' }
MicViennaAnimationBlock >> execute [

	| animation prestate transpiledSpecification oldRecorder |
	resultString := nil.
	errorString := nil.
	forms := nil.
	self bodyNode ifNil: [ ^ self syntaxError ].
	animation := self animation.
	self diagrams ifNotEmpty: [ animation withExecutionTrace ].
	prestate := animation state.
	transpiledSpecification := animation transpiledSpecification.
	oldRecorder := transpiledSpecification _recorder.
	self diagrams ifNotEmpty: [
			transpiledSpecification useEventRecorder:
				(transpiledSpecification state associations collect: [ :assoc | assoc key -> assoc value asOrderedDictionary ])
					asOrderedDictionary ].
	animation
		execute: self bodyNode
		in: self moduleName
		do: [ :result :poststate |
				self resultString: result viennaString prestate: prestate poststate: poststate.
				forms := Array streamContents: [ :stream |
						         self diagrams do: [ :diagramName |
							         (self formFrom: transpiledSpecification diagram: diagramName) ifNotNil: [ :form | stream nextPut: form ] ] ] ]
		ifError: [ :message | ^ self errorString: message ].
	transpiledSpecification _recorder: oldRecorder
]

{ #category : 'executing' }
MicViennaAnimationBlock >> flushResultString [

	forms := nil.
	super flushResultString
]

{ #category : 'private' }
MicViennaAnimationBlock >> formFrom: aViennaTranspiledModularDocument diagram: aString [

	aString = 'sequence' ifTrue: [ ^ self sequenceDiagramFrom: aViennaTranspiledModularDocument ].
	aString = 'state' ifTrue: [ ^ self stateDiagramFrom: aViennaTranspiledModularDocument ].
	^ nil
]

{ #category : 'accessing' }
MicViennaAnimationBlock >> forms [

	^ forms
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
MicViennaAnimationBlock >> printState: aDictionary on: aStream [

	aDictionary ifNotNil: [
			aStream nextPutAll: '{'.
			aDictionary associations
				do: [ :assoc |
						aStream
							nextPutAll: assoc key;
							nextPutAll: '=';
							nextPutAll: (self vdmHighlight: assoc value parent: self bodyNode parent) ]
				separatedBy: [ aStream nextPutAll: ', ' ].
			aStream nextPutAll: '}' ]
]

{ #category : 'accessing' }
MicViennaAnimationBlock >> resultString: aString prestate: aDictionary poststate: anotherDictionary [

	| result |
	result := self vdmHighlight: aString parent: self bodyNode parent.
	self
		ifShowDiffState: [
				anotherDictionary ifNotNil: [
						anotherDictionary keys do: [ :var |
								aDictionary at: var ifPresent: [ :pre |
										pre = (anotherDictionary at: var) ifTrue: [
												aDictionary removeKey: var.
												anotherDictionary removeKey: var ] ] ] ] ]
		otherwise: [ ].
	resultString := self
		                ifShowNoState: [
				                Text streamContents: [ :stream |
						                stream
							                nextPutAll: self bodyText;
							                nextPutAll: ' → ';
							                nextPutAll: result ] ]
		                otherwise: [
				                Text streamContents: [ :stream |
						                self printState: aDictionary on: stream.
						                stream
							                space;
							                nextPutAll: self bodyText;
							                nextPutAll: ' → ';
							                nextPutAll: result;
							                space.
						                self printState: anotherDictionary on: stream ] ]
]

{ #category : 'private' }
MicViennaAnimationBlock >> sequenceDiagramFrom: aViennaTranspiledModularDocument [

	| format scriptSource diagram canvas |
	format := ViennaExecutionTraceSequenceDiagramFormat new
		          root: 'caller';
		          yourself.
	scriptSource := String streamContents: [ :stream |
			                format writeHeaderOn: stream.
			                aViennaTranspiledModularDocument _executionTrace applyToFormat: format on: stream.
			                format writeFooterOn: stream ].
	diagram := MMSequenceDiagramParser new parse: scriptSource.
	diagram isPetit2Failure ifTrue: [ ^ nil ].
	canvas := diagram roassalBuilder build.
	^ canvas
		  extent: canvas encompassingRectangle extent + (20 @ 20);
		  zoomToFit;
		  asForm
]

{ #category : 'accessing' }
MicViennaAnimationBlock >> state [

	^ arguments at: #state ifAbsent: [ nil ]
]

{ #category : 'private' }
MicViennaAnimationBlock >> stateDiagramFrom: aViennaTranspiledModularDocument [

	| format executionTrace scriptSource diagram canvas |
	format := ViennaExecutionTraceStateDiagramFormat new
		          probes: aViennaTranspiledModularDocument _defaultProbes;
		          showsProbeNames: true;
		          showsOperationNames: true;
		          yourself.
	executionTrace := aViennaTranspiledModularDocument _executionTrace.
	executionTrace initial do: [ :event | event applyAssignmentTo: aViennaTranspiledModularDocument ].
	scriptSource := String streamContents: [ :stream |
			                format writeHeaderOn: stream.
			                executionTrace
				                applyToFormat: format
				                on: stream
				                before: [ :event | event applyAssignmentTo: aViennaTranspiledModularDocument ]
				                after: [ :event |  ].
			                format writeFooterOn: stream ].
	diagram := MMStateDiagramParser new parse: scriptSource.
	diagram isPetit2Failure ifTrue: [ ^ nil ].
	canvas := diagram roassalBuilder build.
	^ canvas
		  extent: canvas encompassingRectangle extent + (20 @ 20);
		  zoomToFit;
		  asForm
]
