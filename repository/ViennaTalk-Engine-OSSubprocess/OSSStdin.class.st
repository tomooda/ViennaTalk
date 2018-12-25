Class {
	#name : #OSSStdin,
	#superclass : #Object,
	#instVars : [
		'process'
	],
	#category : #'ViennaTalk-Engine-OSSubprocess'
}

{ #category : #accessing }
OSSStdin >> close [
	process
		ifNotNil: [ process closeStdin.
			process := nil ]
]

{ #category : #accessing }
OSSStdin >> closed [
	^ process isNil
]

{ #category : #streaming }
OSSStdin >> flush [
]

{ #category : #streaming }
OSSStdin >> nextPut: aCharacter [
	self nextPutAll: (String with: aCharacter)
]

{ #category : #streaming }
OSSStdin >> nextPutAll: aString [
	process writeToStdin: aString asByteArray
]

{ #category : #accessing }
OSSStdin >> process: aProcessWrapper [
	process := aProcessWrapper 
]
