Class {
	#name : #OSSStdout,
	#superclass : #Object,
	#instVars : [
		'process',
		'buffer',
		'contentSize',
		'readIndex'
	],
	#category : #'ViennaTalk-Engine-OSSubprocess'
}

{ #category : #accessing }
OSSStdout >> close [
	process
		ifNotNil: [ process closeStdout.
			process := nil ]
]

{ #category : #accessing }
OSSStdout >> closed [
	^ process isNil
]

{ #category : #'initialize-release' }
OSSStdout >> initialize [
	super initialize.
	buffer := ByteArray new: 4096.
	contentSize := 0.
	readIndex := 1
]

{ #category : #streaming }
OSSStdout >> next [
	readIndex > contentSize
		ifTrue: [ contentSize := process readFromStdoutInto: buffer.
			readIndex := 1 ].
	readIndex > contentSize
		ifTrue: [ ^ nil ]
		ifFalse: [ | byte |
			byte := buffer at: readIndex.
			readIndex := readIndex + 1.
			^ Character value: byte ]
]

{ #category : #streaming }
OSSStdout >> next: anInteger [
	^ String
		streamContents: [ :stream | 
			anInteger
				timesRepeat: [ | ch |
					ch := self next.
					ch ifNotNil: [ stream nextPut: ch ] ] ]
]

{ #category : #accessing }
OSSStdout >> process: aProcessWrapper [
	process := aProcessWrapper 
]
