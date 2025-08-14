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
ViennaExecutionTraceAbstractRecorder >> call: aString args: anArray [

	^ self subclassResponsibility
]

{ #category : 'recording' }
ViennaExecutionTraceAbstractRecorder >> endRecording [

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
ViennaExecutionTraceAbstractRecorder >> record: aBlock do: anotherBlock [

	self beginRecording.
	aBlock ensure: [
			self endRecording.
			^ anotherBlock cull: self output ]
]

{ #category : 'recording' }
ViennaExecutionTraceAbstractRecorder >> return: aString value: anObject [

	^ self subclassResponsibility
]

{ #category : 'recording' }
ViennaExecutionTraceAbstractRecorder >> stateDiffBlock: aBlock [

	^ self subclassResponsibility
]
