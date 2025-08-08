Class {
	#name : 'ViennaExecutionTraceRecorder',
	#superclass : 'ViennaExecutionTraceAbstractRecorder',
	#instVars : [
		'format',
		'outputStream'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Recorder',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Recorder'
}

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
ViennaExecutionTraceRecorder >> call: aString args: anArray [

	format writeCall: aString args: anArray on: outputStream
]

{ #category : 'defaults' }
ViennaExecutionTraceRecorder >> defaultOutputStream [

	^ String new writeStream
]

{ #category : 'recording' }
ViennaExecutionTraceRecorder >> endRecording [

	format writeFooterOn: outputStream
]

{ #category : 'initialization' }
ViennaExecutionTraceRecorder >> initialize [
	super initialize.
	format := ViennaExecutionTraceSequenceDiagramFormatter new.
	outputStream := self defaultOutputStream
]

{ #category : 'accessing' }
ViennaExecutionTraceRecorder >> output [

	^ outputStream contents
]

{ #category : 'recording' }
ViennaExecutionTraceRecorder >> return: aString value: anObject [

	format writeReturn: aString value: anObject on: outputStream
]

{ #category : 'recording' }
ViennaExecutionTraceRecorder >> state: aDictionary [

	format writeState: aDictionary on: outputStream
]

{ #category : 'accessing' }
ViennaExecutionTraceRecorder >> useSequenceDiagramFormat: aString [

	format := ViennaExecutionTraceSequenceDiagramFormatter new
		          root: aString;
		          yourself
]

{ #category : 'accessing' }
ViennaExecutionTraceRecorder >> useStateDiagramFormat: aCollectionOfBlockClosure [

	format := ViennaExecutionTraceStateDiagramFormatter new
		          probes: aCollectionOfBlockClosure;
		          yourself
]
