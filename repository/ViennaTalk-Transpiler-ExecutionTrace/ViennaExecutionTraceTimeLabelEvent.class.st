Class {
	#name : 'ViennaExecutionTraceTimeLabelEvent',
	#superclass : 'Object',
	#instVars : [
		'label'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Query',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Query'
}

{ #category : 'formatting' }
ViennaExecutionTraceTimeLabelEvent >> applyToFormat: aViennaExecutionRecordFormat on: aStream before: aBlock after: anotherBlock [

	aBlock cull: self.
	aViennaExecutionRecordFormat
		writeTimeLabel: label
		on: aStream.
	anotherBlock cull: self
]

{ #category : 'accessing' }
ViennaExecutionTraceTimeLabelEvent >> iconName [

	^ #search
]

{ #category : 'accessing' }
ViennaExecutionTraceTimeLabelEvent >> label [

	^ label
]

{ #category : 'accessing' }
ViennaExecutionTraceTimeLabelEvent >> label: aString [

	label := aString
]

{ #category : 'accessing' }
ViennaExecutionTraceTimeLabelEvent >> source [

	^ '--@time ' , label
]

{ #category : 'private' }
ViennaExecutionTraceTimeLabelEvent >> withinModule [

	
]
