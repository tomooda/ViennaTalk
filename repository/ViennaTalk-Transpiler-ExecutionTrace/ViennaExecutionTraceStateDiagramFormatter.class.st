Class {
	#name : 'ViennaExecutionTraceStateDiagramFormatter',
	#superclass : 'ViennaExecutionTraceFormat',
	#instVars : [
		'probes',
		'triggeredByAssignment',
		'triggerOperations',
		'state',
		'stateStack',
		'stateNames',
		'transitions'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Formats',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Formats'
}

{ #category : 'accessing' }
ViennaExecutionTraceStateDiagramFormatter >> abstractState [

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
ViennaExecutionTraceStateDiagramFormatter >> addProbe: aBlock [

	probes := probes copyWith: aBlock
]

{ #category : 'adding' }
ViennaExecutionTraceStateDiagramFormatter >> addTriggerOperation: aString [

	triggerOperations add: aString.
	triggeredByAssignment := false
]

{ #category : 'initialization' }
ViennaExecutionTraceStateDiagramFormatter >> initialize [

	super initialize.
	probes := Array new.
	triggerOperations := Set new.
	triggeredByAssignment := true.
	stateStack := OrderedCollection new: 1024.
	stateNames := Dictionary new.
	transitions := Set new
]

{ #category : 'adding' }
ViennaExecutionTraceStateDiagramFormatter >> probes: aCollectionOfBlockClosure [

	probes := aCollectionOfBlockClosure asArray
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormatter >> transitionFrom: preStateString to: postStateString [

	^ (preStateString ifNil: [ '[*]' ]) , ' --> '
	  , (postStateString ifNil: [ '[*]' ])
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormatter >> writeCall: aString args: anArray on: aStream [

	(triggerOperations includes: aString) ifTrue: [
		stateStack addLast: self abstractState ]
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormatter >> writeEndStateOn: aStream [

	transitions add: (self transitionFrom: state to: nil)
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormatter >> writeFooterOn: aStream [

	self writeEndStateOn: aStream.
	self
		writeStateNamesOn: aStream;
		writeTransitionsOn: aStream
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormatter >> writeHeaderOn: aStream [

	aStream
		nextPutAll: 'stateDiagram';
		cr.
	self writeStartStateOn: aStream
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormatter >> writeReturn: aString value: anObject on: aStream [

	(triggerOperations includes: aString) ifTrue: [
			| preState postState |
			preState := stateStack removeLast.
			postState := self abstractState.
			transitions add: (self transitionFrom: preState to: postState) ]
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormatter >> writeStartStateOn: aStream [

	| initialState |
	initialState := state := self abstractState.
	transitions add: (self transitionFrom: nil to: initialState)
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormatter >> writeState: aDictionary on: outputStream [

	triggeredByAssignment
		ifTrue: [
				| preState postState |
				preState := state.
				postState := state := self abstractState.
				transitions add: (self transitionFrom: preState to: postState) ]
		ifFalse: [ state := self abstractState ]
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormatter >> writeStateNamesOn: aStream [

	stateNames keysAndValuesDo: [ :abstractState :name |
			aStream
				nextPutAll: '  state "';
				nextPutAll: abstractState;
				nextPutAll: '" as ';
				nextPutAll: name;
				cr ]
]

{ #category : 'formatting' }
ViennaExecutionTraceStateDiagramFormatter >> writeTransitionsOn: aStream [

	transitions do: [ :string |
			aStream
				nextPutAll: '  ';
				nextPutAll: string;
				cr ]
]
