Class {
	#name : 'ViennaNumStepsExceeded',
	#superclass : 'ViennaError',
	#instVars : [
		'modularDocument'
	],
	#category : 'ViennaTalk-VDMPad-Core',
	#package : 'ViennaTalk-VDMPad-Core'
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
