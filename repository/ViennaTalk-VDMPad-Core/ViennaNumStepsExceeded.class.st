Class {
	#name : 'ViennaNumStepsExceeded',
	#superclass : 'ViennaError',
	#instVars : [
		'modularDocument'
	],
	#category : 'ViennaTalk-VDMPad-Core-Transpiler',
	#package : 'ViennaTalk-VDMPad-Core',
	#tag : 'Transpiler'
}

{ #category : 'signaling' }
ViennaNumStepsExceeded class >> signal: aViennaTranspiledModularDocumentForVDMPad [

	^ self new
		  modularDocument: aViennaTranspiledModularDocumentForVDMPad;
		  signal
]

{ #category : 'accessing' }
ViennaNumStepsExceeded >> modularDocument [

	^ modularDocument
]

{ #category : 'accessing' }
ViennaNumStepsExceeded >> modularDocument: aViennaTranspiledModularDocumentForVDMPad [

	modularDocument := aViennaTranspiledModularDocumentForVDMPad
]
