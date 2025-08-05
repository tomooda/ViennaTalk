Class {
	#name : 'ViennaExecutionTraceNullRecorder',
	#superclass : 'ViennaExecutionTraceAbstractRecorder',
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Recorder',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Recorder'
}

{ #category : 'recording' }
ViennaExecutionTraceNullRecorder >> beginRecording [

	
]

{ #category : 'recording' }
ViennaExecutionTraceNullRecorder >> call: aString args: anArray [

	
]

{ #category : 'recording' }
ViennaExecutionTraceNullRecorder >> endRecording [

	
]

{ #category : 'accessing' }
ViennaExecutionTraceNullRecorder >> output [

	^ String new
]

{ #category : 'recording' }
ViennaExecutionTraceNullRecorder >> record: aBlock do: anotherBlock [

	aBlock ensure: [ ^ anotherBlock cull: '' ]
]

{ #category : 'recording' }
ViennaExecutionTraceNullRecorder >> return: aString value: anObject [

	
]

{ #category : 'recording' }
ViennaExecutionTraceNullRecorder >> state: aDictionary [

	
]
