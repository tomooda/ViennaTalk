Class {
	#name : 'ViennaExecutionTraceCSVFormat',
	#superclass : 'ViennaExecutionTraceFormat',
	#instVars : [
		'initialState'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Formats',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Formats'
}

{ #category : 'private' }
ViennaExecutionTraceCSVFormat >> escape: aString [

	^ (aString copyReplaceAll: '\' with: '\\')
		  copyReplaceAll: ','
		  with: '\,'
]

{ #category : 'accessing' }
ViennaExecutionTraceCSVFormat >> initialState [

	^ initialState
]

{ #category : 'accessing' }
ViennaExecutionTraceCSVFormat >> initialState: aDicitonary [

	initialState := aDicitonary
]

{ #category : 'user interface' }
ViennaExecutionTraceCSVFormat >> open: aViennaExecutionTraceRecorder withTitle: aString [

	^ aViennaExecutionTraceRecorder output
		  inspect;
		  yourself
]

{ #category : 'formatting' }
ViennaExecutionTraceCSVFormat >> writeCall: aString module: anotherString args: anArray on: aStream [

	aStream
		nextPutAll: 'c,';
		nextPutAll: anotherString;
		nextPut: $,;
		nextPutAll: aString.
	anArray do: [ :arg |
			aStream
				nextPut: $,;
				nextPutAll: (self escape: arg viennaString) ].
	aStream cr
]

{ #category : 'formatting' }
ViennaExecutionTraceCSVFormat >> writeFooterOn: aStream [

	
]

{ #category : 'formatting' }
ViennaExecutionTraceCSVFormat >> writeHeaderOn: aStream [

	aStream nextPut: $s.
	initialState keysAndValuesDo: [ :moduleName :moduleState |
			aStream
				nextPut: $,;
				nextPutAll: moduleName.
			moduleState fieldNamesAndValuesDo: [ :variableName :value |
					aStream
						nextPut: $,;
						nextPutAll: variableName;
						nextPutAll: ':=';
						nextPutAll: (self escape: value viennaString) ] ].
	aStream cr
]

{ #category : 'formatting' }
ViennaExecutionTraceCSVFormat >> writeReturn: aString module: anotherString value: anObject on: aStream [

	aStream
		nextPutAll: 'r,';
		nextPutAll: anotherString;
		nextPut: $,;
		nextPutAll: aString;
		nextPut: $,;
		nextPutAll: (self escape: anObject viennaString);
		cr
]

{ #category : 'formatting' }
ViennaExecutionTraceCSVFormat >> writeStateDiffBlock: aBlock on: aStream [

	| moduleAndAssignments |
	aStream nextPut: $s.
	moduleAndAssignments := aBlock value.
	aStream
		nextPut: $,;
		nextPutAll: moduleAndAssignments key.
	moduleAndAssignments value do: [ :varAndValue |
			aStream
				nextPut: $,;
				nextPutAll: varAndValue key;
				nextPutAll: ':=';
				nextPutAll: (self escape: varAndValue value viennaString) ].
	aStream cr
]
