Class {
	#name : 'ViennaExecutionTraceNullRecorder',
	#superclass : 'ViennaExecutionTraceAbstractRecorder',
	#category : 'ViennaTalk-ExecutionTrace-Core-Recorder',
	#package : 'ViennaTalk-ExecutionTrace-Core',
	#tag : 'Recorder'
}

{ #category : 'recording' }
ViennaExecutionTraceNullRecorder >> beginRecording [

	
]

{ #category : 'recording' }
ViennaExecutionTraceNullRecorder >> call: aString module: anotherString args: anArray [

	
]

{ #category : 'recording' }
ViennaExecutionTraceNullRecorder >> endRecording [

	
]

{ #category : 'recording' }
ViennaExecutionTraceNullRecorder >> forceRecording: aBoolean [

	
]

{ #category : 'accessing' }
ViennaExecutionTraceNullRecorder >> openWithTitle: aString [

	
]

{ #category : 'accessing' }
ViennaExecutionTraceNullRecorder >> output [

	^ String new
]

{ #category : 'recording' }
ViennaExecutionTraceNullRecorder >> pauseRecording [

	
]

{ #category : 'recording' }
ViennaExecutionTraceNullRecorder >> record: aBlock do: anotherBlock [

	aBlock ensure: [ ^ anotherBlock cull: '' ]
]

{ #category : 'recording' }
ViennaExecutionTraceNullRecorder >> resumeRecording [

	
]

{ #category : 'recording' }
ViennaExecutionTraceNullRecorder >> return: aString module: anotherString value: anObject [

	
]

{ #category : 'recording' }
ViennaExecutionTraceNullRecorder >> stateDiffBlock: aBlock [

	
]
