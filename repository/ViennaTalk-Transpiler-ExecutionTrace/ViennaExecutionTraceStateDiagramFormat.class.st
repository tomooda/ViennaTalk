Class {
	#name : 'ViennaExecutionTraceStateDiagramFormat',
	#superclass : 'ViennaExecutionTraceFormat',
	#instVars : [
		'probes',
		'triggeredByAssignment',
		'triggerOperations',
		'state',
		'stateStack',
		'stateNames',
		'operationStack',
		'transitions'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Formats',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Formats'
}

{ #category : 'accessing' }
ViennaExecutionTraceStateDiagramFormat >> abstractState [

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

{ #category : 'adding' }
ViennaExecutionTraceStateDiagramFormat >> addTriggerOperation: aString [

	triggerOperations add: aString.
	triggeredByAssignment := false
]

{ #category : 'initialization' }
ViennaExecutionTraceStateDiagramFormat >> initialize [

	super initialize.
	probes := Array new.
	triggerOperations := Set new.
	triggeredByAssignment := true.
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

{ #category : 'adding' }
ViennaExecutionTraceStateDiagramFormat >> probes: aCollectionOfBlockClosure [

	probes := aCollectionOfBlockClosure asArray
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormat >> transitionFrom: preStateString to: postStateString [

	^ (preStateString ifNil: [ '[*]' ]) , ' --> '
	  , (postStateString ifNil: [ '[*]' ])
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
ViennaExecutionTraceStateDiagramFormat >> writeCall: aString args: anArray on: aStream [

	(triggerOperations includes: aString) ifTrue: [
		stateStack addLast: self abstractState ].
	operationStack addLast: aString
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
ViennaExecutionTraceStateDiagramFormat >> writeReturn: aString value: anObject on: aStream [

	(triggerOperations includes: aString) ifTrue: [
			| preState postState |
			preState := stateStack removeLast.
			postState := self abstractState.
			transitions add: (self
					 transitionFrom: preState
					 to: postState
					 operation: operationStack last) ].
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

	triggeredByAssignment
		ifTrue: [
				| preState postState |
				preState := state.
				postState := state := self abstractState.
				transitions add: (self
						 transitionFrom: preState
						 to: postState
						 operation: operationStack last) ]
		ifFalse: [ state := self abstractState ]
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormat >> writeStateNamesOn: aStream [

	stateNames keysAndValuesDo: [ :abstractState :name |
			aStream
				nextPutAll: '  state "';
				nextPutAll: abstractState;
				nextPutAll: '" as ';
				nextPutAll: name;
				cr ]
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormat >> writeTransitionsOn: aStream [

	transitions do: [ :string |
			aStream
				nextPutAll: '  ';
				nextPutAll: string;
				cr ]
]
