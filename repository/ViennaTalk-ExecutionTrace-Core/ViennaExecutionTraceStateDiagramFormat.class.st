Class {
	#name : 'ViennaExecutionTraceStateDiagramFormat',
	#superclass : 'ViennaExecutionTraceFormat',
	#instVars : [
		'probes',
		'state',
		'stateStack',
		'stateNames',
		'operationStack',
		'transitions',
		'showsProbeNames',
		'showsOperationNames'
	],
	#category : 'ViennaTalk-ExecutionTrace-Core-Formats',
	#package : 'ViennaTalk-ExecutionTrace-Core',
	#tag : 'Formats'
}

{ #category : 'accessing' }
ViennaExecutionTraceStateDiagramFormat >> abstractState [

	^ showsProbeNames
		  ifTrue: [ self abstractStateWithName ]
		  ifFalse: [ self abstractStateWithoutName ]
]

{ #category : 'accessing' }
ViennaExecutionTraceStateDiagramFormat >> abstractStateWithName [

	| abstractState |
	abstractState := String streamContents: [ :stream |
			                 probes
				                 do: [ :probe |
						                 stream
							                 nextPutAll: probe name;
							                 nextPut: $=.
						                 probe value viennaStringOn: stream ]
				                 separatedBy: [
						                 stream
							                 nextPut: $,;
							                 cr ] ].
	^ stateNames
		  at: abstractState
		  ifAbsentPut: [ 's' , (stateNames size + 1) printString ]
]

{ #category : 'accessing' }
ViennaExecutionTraceStateDiagramFormat >> abstractStateWithoutName [

	| abstractState |
	abstractState := String streamContents: [ :stream |
			                 probes
				                 do: [ :probe |
				                 probe value viennaStringOn: stream ]
				                 separatedBy: [ stream nextPut: $, ] ].
	^ stateNames
		  at: abstractState
		  ifAbsentPut: [ 's' , (stateNames size + 1) printString ]
]

{ #category : 'adding' }
ViennaExecutionTraceStateDiagramFormat >> addProbe: aBlock [

	probes := probes copyWith: aBlock
]

{ #category : 'accessing' }
ViennaExecutionTraceStateDiagramFormat >> hideOperationNames [

	showsOperationNames := false
]

{ #category : 'accessing' }
ViennaExecutionTraceStateDiagramFormat >> hideProbeNames [

	showsProbeNames := false
]

{ #category : 'initialization' }
ViennaExecutionTraceStateDiagramFormat >> initialize [

	super initialize.
	showsProbeNames := false.
	showsOperationNames := false.
	probes := Array new.
	stateStack := OrderedCollection new: 1024.
	operationStack := OrderedCollection new: 1024.
	stateNames := Dictionary new.
	transitions := ViennaOrderedSet new
]

{ #category : 'user interface' }
ViennaExecutionTraceStateDiagramFormat >> open: aViennaExecutionTraceRecorder withTitle: aString [

	^ aViennaExecutionTraceRecorder output
		  openMicromaidBuilderWith: [ :builder | builder gap: 120 ]
		  title: aString
]

{ #category : 'accessing' }
ViennaExecutionTraceStateDiagramFormat >> probes: aCollectionOfBlockClosure [

	probes := aCollectionOfBlockClosure asArray
]

{ #category : 'accessing' }
ViennaExecutionTraceStateDiagramFormat >> showOperationNames [

	showsOperationNames := true
]

{ #category : 'accessing' }
ViennaExecutionTraceStateDiagramFormat >> showProbeNames [

	showsProbeNames := true
]

{ #category : 'accessing' }
ViennaExecutionTraceStateDiagramFormat >> showsOperationNames [

	^ showsOperationNames
]

{ #category : 'accessing' }
ViennaExecutionTraceStateDiagramFormat >> showsOperationNames: aBoolean [

	showsOperationNames := aBoolean = true
]

{ #category : 'accessing' }
ViennaExecutionTraceStateDiagramFormat >> showsProbeNames [

	^ showsProbeNames
]

{ #category : 'accessing' }
ViennaExecutionTraceStateDiagramFormat >> showsProbeNames: aBoolean [

	showsProbeNames := aBoolean = true
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormat >> transitionFrom: preStateString to: postStateString operation: operationString [

	^ (preStateString ifNil: [ '[*]' ]) , ' --> '
	  , (postStateString ifNil: [ '[*]' ])
	  ,
	  (operationString
		   ifNotNil: [ ' : ' , operationString ]
		   ifNil: [ '' ])
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormat >> writeAssert: aString on: aStream [

	
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormat >> writeCall: aString module: anotherString args: anArray on: aStream [

	operationStack addLast: anotherString , '`' , aString
]

{ #category : 'writing' }
ViennaExecutionTraceStateDiagramFormat >> writeEndStateOn: aStream [

	transitions add: (self transitionFrom: state to: nil operation: nil)
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormat >> writeFooterOn: aStream [

	self writeEndStateOn: aStream.
	self
		writeStateNamesOn: aStream;
		writeTransitionsOn: aStream
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormat >> writeHeaderOn: aStream [

	aStream
		nextPutAll: 'stateDiagram';
		cr.
	self writeStartStateOn: aStream
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormat >> writeReturn: aString module: anotherString value: anObject on: aStream [

	operationStack removeLast
]

{ #category : 'writing' }
ViennaExecutionTraceStateDiagramFormat >> writeStartStateOn: aStream [

	| initialState |
	initialState := state := self abstractState.
	transitions add:
		(self transitionFrom: nil to: initialState operation: nil)
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormat >> writeStateDiffBlock: aBlock on: aStream [

	| preState postState |
	preState := state.
	postState := state := self abstractState.
	transitions add: (self
			 transitionFrom: preState
			 to: postState
			 operation:
				 ((showsOperationNames and: [ operationStack notEmpty ])
					  ifTrue: [ operationStack last ]
					  ifFalse: [ nil ]))
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormat >> writeStateNamesOn: aStream [

	stateNames keysAndValuesDo: [ :abstractState :name |
			aStream
				nextPutAll: '  state "';
				nextPutAll: abstractState asHTMLString;
				nextPutAll: '" as ';
				nextPutAll: name;
				cr ]
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormat >> writeTimeLabel: aString on: aStream [

	
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormat >> writeTransitionsOn: aStream [

	transitions do: [ :string |
			aStream
				nextPutAll: '  ';
				nextPutAll: string;
				cr ]
]
