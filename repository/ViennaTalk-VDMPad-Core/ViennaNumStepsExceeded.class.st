Class {
	#name : 'ViennaNumStepsExceeded',
	#superclass : 'ViennaError',
	#instVars : [
		'modularDocument'
	],
	#category : 'ViennaTalk-VDMPad-Core-Engine',
	#package : 'ViennaTalk-VDMPad-Core',
	#tag : 'Engine'
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
