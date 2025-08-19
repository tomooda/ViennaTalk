Class {
	#name : 'ViennaExecutionTraceAbstractRecorder',
	#superclass : 'Object',
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Recorder',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Recorder'
}

{ #category : 'recording' }
ViennaExecutionTraceAbstractRecorder >> beginRecording [

	^ self subclassResponsibility
]

{ #category : 'recording' }
ViennaExecutionTraceAbstractRecorder >> call: aString module: anotherString args: anArray [

	^ self subclassResponsibility
]

{ #category : 'recording' }
ViennaExecutionTraceAbstractRecorder >> endRecording [

	^ self subclassResponsibility
]

{ #category : 'recording' }
ViennaExecutionTraceAbstractRecorder >> forceRecording: aBoolean [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaExecutionTraceAbstractRecorder >> openWithTitle: aString [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaExecutionTraceAbstractRecorder >> output [

	^ self subclassResponsibility
]

{ #category : 'recording' }
ViennaExecutionTraceAbstractRecorder >> pauseRecording [

	^ self subclassResponsibility
]

{ #category : 'evaluating' }
ViennaExecutionTraceAbstractRecorder >> pauseRecordingDuring: aBlock [

	[
		self pauseRecording.
		aBlock value ] ensure: [ self resumeRecording ]
]

{ #category : 'recording' }
ViennaExecutionTraceAbstractRecorder >> record: aBlock do: anotherBlock [

	self beginRecording.
	aBlock ensure: [
			self endRecording.
			^ anotherBlock cull: self output ]
]

{ #category : 'recording' }
ViennaExecutionTraceAbstractRecorder >> resumeRecording [

	^ self subclassResponsibility
]

{ #category : 'recording' }
ViennaExecutionTraceAbstractRecorder >> return: aString module: anotherString value: anObject [

	^ self subclassResponsibility
]

{ #category : 'recording' }
ViennaExecutionTraceAbstractRecorder >> stateDiffBlock: aBlock [

	^ self subclassResponsibility
]
