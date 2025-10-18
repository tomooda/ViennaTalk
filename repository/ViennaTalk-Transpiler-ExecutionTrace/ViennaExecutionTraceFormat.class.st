Class {
	#name : 'ViennaExecutionTraceFormat',
	#superclass : 'Object',
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Formats',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Formats'
}

{ #category : 'user interface' }
ViennaExecutionTraceFormat >> open: aViennaExecutionTraceRecorder withTitle: aString [

	^ self subclassResponsibility
]

{ #category : 'formatting' }
ViennaExecutionTraceFormat >> writeAssert: aString on: aStream [

	^ self subclassResponsibility
]

{ #category : 'formatting' }
ViennaExecutionTraceFormat >> writeCall: aString module: anotherString args: anArray on: aStream [

	^ self subclassResponsibility
]

{ #category : 'formatting' }
ViennaExecutionTraceFormat >> writeFooterOn: aStream [

	^ self subclassResponsibility
]

{ #category : 'formatting' }
ViennaExecutionTraceFormat >> writeHeaderOn: aStream [

	^ self subclassResponsibility
]

{ #category : 'formatting' }
ViennaExecutionTraceFormat >> writeReturn: aString module: anotherString value: anObject on: aStream [

	^ self subclassResponsibility
]

{ #category : 'formatting' }
ViennaExecutionTraceFormat >> writeStateDiffBlock: aBlock on: aStream [

	^ self subclassResponsibility
]

{ #category : 'formatting' }
ViennaExecutionTraceFormat >> writeTimeLabel: aString on: aStream [

	^ self subclassResponsibility
]
