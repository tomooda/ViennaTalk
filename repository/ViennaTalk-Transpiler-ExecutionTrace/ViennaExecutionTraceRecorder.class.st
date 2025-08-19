Class {
	#name : 'ViennaExecutionTraceRecorder',
	#superclass : 'ViennaExecutionTraceAbstractRecorder',
	#instVars : [
		'format',
		'outputStream',
		'forced',
		'paused'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Recorder',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Recorder'
}

{ #category : 'instance creation' }
ViennaExecutionTraceRecorder class >> forCSV: aDictionary [

	^ self new
		  useCSVFormat: aDictionary;
		  yourself
]

{ #category : 'instance creation' }
ViennaExecutionTraceRecorder class >> forSequenceDiagram: aString [

	^ self new
		  useSequenceDiagramFormat: aString;
		  yourself
]

{ #category : 'instance creation' }
ViennaExecutionTraceRecorder class >> forStateDiagram: aCollectionOfBlockClosure [

	^ self new
		  useStateDiagramFormat: aCollectionOfBlockClosure;
		  yourself
]

{ #category : 'recording' }
ViennaExecutionTraceRecorder >> beginRecording [

	format writeHeaderOn: outputStream
]

{ #category : 'recording' }
ViennaExecutionTraceRecorder >> call: aString module: anotherString args: anArray [

	(paused not or: [ forced ]) ifTrue: [
			format
				writeCall: aString
				module: anotherString
				args: anArray
				on: outputStream ]
]

{ #category : 'defaults' }
ViennaExecutionTraceRecorder >> defaultOutputStream [

	^ String new writeStream
]

{ #category : 'recording' }
ViennaExecutionTraceRecorder >> endRecording [

	format writeFooterOn: outputStream
]

{ #category : 'recording' }
ViennaExecutionTraceRecorder >> forceRecording: aBoolean [

	forced := aBoolean = true
]

{ #category : 'initialization' }
ViennaExecutionTraceRecorder >> initialize [

	super initialize.
	format := ViennaExecutionTraceSequenceDiagramFormat new.
	outputStream := self defaultOutputStream.
	forced := false.
	paused := false
]

{ #category : 'accessing' }
ViennaExecutionTraceRecorder >> openWithTitle: aString [

	format open: self withTitle: aString
]

{ #category : 'accessing' }
ViennaExecutionTraceRecorder >> output [

	^ outputStream contents
]

{ #category : 'recording' }
ViennaExecutionTraceRecorder >> pauseRecording [

	paused := true
]

{ #category : 'recording' }
ViennaExecutionTraceRecorder >> resumeRecording [

	paused := false
]

{ #category : 'recording' }
ViennaExecutionTraceRecorder >> return: aString module: anotherString value: anObject [

	(paused not or: [ forced ]) ifTrue: [
			format
				writeReturn: aString
				module: anotherString
				value: anObject
				on: outputStream ]
]

{ #category : 'recording' }
ViennaExecutionTraceRecorder >> stateDiffBlock: aBlock [

	(paused not or: [ forced ]) ifTrue: [
		format writeStateDiffBlock: aBlock on: outputStream ]
]

{ #category : 'accessing' }
ViennaExecutionTraceRecorder >> useCSVFormat: aDictionary [

	format := ViennaExecutionTraceCSVFormat new
		          initialState: aDictionary;
		          yourself
]

{ #category : 'accessing' }
ViennaExecutionTraceRecorder >> useSequenceDiagramFormat: aString [

	format := ViennaExecutionTraceSequenceDiagramFormat new
		          root: aString;
		          yourself
]

{ #category : 'accessing' }
ViennaExecutionTraceRecorder >> useStateDiagramFormat: aCollectionOfBlockClosure [

	format := ViennaExecutionTraceStateDiagramFormat new
		          probes: aCollectionOfBlockClosure;
		          yourself
]
