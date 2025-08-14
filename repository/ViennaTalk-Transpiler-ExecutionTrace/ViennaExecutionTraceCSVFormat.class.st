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
ViennaExecutionTraceCSVFormat >> writeCall: aString args: anArray on: aStream [

	aStream
		nextPutAll: 'c,';
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
			moduleState fieldNamesAndValuesDo: [ :variableName :value |
					aStream
						nextPut: $,;
						nextPutAll: moduleName;
						nextPut: $`;
						nextPutAll: variableName;
						nextPutAll: ':=';
						nextPutAll: (self escape: value viennaString) ] ].
	aStream cr
]

{ #category : 'formatting' }
ViennaExecutionTraceCSVFormat >> writeReturn: aString value: anObject on: aStream [

	aStream
		nextPutAll: 'r,';
		nextPutAll: aString;
		nextPut: $,;
		nextPutAll: (self escape: anObject viennaString);
		cr
]

{ #category : 'formatting' }
ViennaExecutionTraceCSVFormat >> writeStateDiffBlock: aBlock on: aStream [

	aStream nextPut: $s.
	aBlock value do: [ :assoc |
			aStream
				nextPut: $,;
				nextPutAll: assoc key;
				nextPutAll: ':=';
				nextPutAll: (self escape: assoc value viennaString) ].
	aStream cr
]
