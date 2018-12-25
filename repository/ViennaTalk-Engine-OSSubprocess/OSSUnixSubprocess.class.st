Class {
	#name : #OSSUnixSubprocess,
	#superclass : #Object,
	#instVars : [
		'command',
		'arguments',
		'process'
	],
	#category : #'ViennaTalk-Engine-OSSubprocess'
}

{ #category : #accessing }
OSSUnixSubprocess >> arguments: anArrayOfString [
	arguments := anArrayOfString
]

{ #category : #accessing }
OSSUnixSubprocess >> command [
	^ command
]

{ #category : #accessing }
OSSUnixSubprocess >> command: aString [
	 command := aString asFileReference basename
]

{ #category : #'initialize-release' }
OSSUnixSubprocess >> initialize [
	super initialize.
	command := String new.
	arguments := Array new.
]

{ #category : #accessing }
OSSUnixSubprocess >> isRunning [
	^ process notNil and: [ process isRunning ]
]

{ #category : #accessing }
OSSUnixSubprocess >> redirectStderr [
]

{ #category : #accessing }
OSSUnixSubprocess >> redirectStdin [
	
]

{ #category : #accessing }
OSSUnixSubprocess >> redirectStdout [
	
]

{ #category : #accessing }
OSSUnixSubprocess >> run [
	process := ProcessWrapper new
		useStdout;
		startWithShellCommand: command , ' ' , (' ' join: arguments);
		yourself
]

{ #category : #accessing }
OSSUnixSubprocess >> sigkill [
	process
		ifNotNil: [ process terminate.
			process := nil ]
]

{ #category : #accessing }
OSSUnixSubprocess >> sigterm [
	process
		ifNotNil: [ process terminate.
			process := nil ]
]

{ #category : #accessing }
OSSUnixSubprocess >> stdinStream [
	^ OSSStdin new
		process: process;
		yourself
]

{ #category : #accessing }
OSSUnixSubprocess >> stdoutStream [
	^ OSSStdout new
		process: process;
		yourself
]

{ #category : #accessing }
OSSUnixSubprocess >> terminate [
	process
		ifNotNil: [ process terminate.
			process := nil ]
]
