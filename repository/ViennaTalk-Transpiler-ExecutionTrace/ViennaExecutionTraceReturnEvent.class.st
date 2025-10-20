Class {
	#name : 'ViennaExecutionTraceReturnEvent',
	#superclass : 'ViennaExecutionTraceEvent',
	#instVars : [
		'operation',
		'returnValue'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Events',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Events'
}

{ #category : 'instance creation' }
ViennaExecutionTraceReturnEvent class >> module: aString operation: anotherString returnValue: anObject [

	^ self new
		  setModule: aString operation: anotherString returnValue: anObject;
		  yourself
]

{ #category : 'enumerating' }
ViennaExecutionTraceReturnEvent >> allAssignmentChildrenDo: aBlock [

	
]

{ #category : 'enumerating' }
ViennaExecutionTraceReturnEvent >> allTipChildrenDo: aBlock [

	aBlock value: self
]

{ #category : 'formatting' }
ViennaExecutionTraceReturnEvent >> applyToFormat: aViennaExecutionRecordFormat on: aStream before: aBlock after: anotherBlock [

	aBlock cull: self.
	aViennaExecutionRecordFormat
		writeReturn: operation
		module: module
		value: returnValue
		on: aStream.
	anotherBlock cull: self
]

{ #category : 'accessing' }
ViennaExecutionTraceReturnEvent >> children [

	^ #(  )
]

{ #category : 'enumerating' }
ViennaExecutionTraceReturnEvent >> globalWrites [

	^ OrderedDictionary new
]

{ #category : 'accessing' }
ViennaExecutionTraceReturnEvent >> iconName [

	^ #undo
]

{ #category : 'testing' }
ViennaExecutionTraceReturnEvent >> isReturnEvent [

	^ true
]

{ #category : 'enumerating' }
ViennaExecutionTraceReturnEvent >> modulesAndAssignmentsDo: aBlock [

	
]

{ #category : 'accessing' }
ViennaExecutionTraceReturnEvent >> operation [

	^ operation
]

{ #category : 'accessing' }
ViennaExecutionTraceReturnEvent >> operation: aString [

	operation := aString
]

{ #category : 'private' }
ViennaExecutionTraceReturnEvent >> poststateFromPrestate: aDictionary [

	^ aDictionary
]

{ #category : 'accessing' }
ViennaExecutionTraceReturnEvent >> returnValue [

	^ returnValue
]

{ #category : 'accessing' }
ViennaExecutionTraceReturnEvent >> returnValue: anObject [

	returnValue := anObject
]

{ #category : 'private' }
ViennaExecutionTraceReturnEvent >> setModule: aString operation: anotherString returnValue: anObject [

	module := aString.
	operation := anotherString.
	returnValue := anObject
]

{ #category : 'accessing' }
ViennaExecutionTraceReturnEvent >> source [

	^ (returnValue isKindOf: ViennaTranspiledObject)
		  ifTrue: [ 'return' ]
		  ifFalse: [ 'return ' , returnValue viennaString ]
]

{ #category : 'private' }
ViennaExecutionTraceReturnEvent >> withinModule [

	
]
