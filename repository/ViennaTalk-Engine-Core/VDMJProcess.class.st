Class {
	#name : #VDMJProcess,
	#superclass : #ViennaEngine,
	#instVars : [
		'process',
		'reader',
		'writer',
		'lock',
		'executor'
	],
	#classVars : [
		'Registry'
	],
	#category : 'ViennaTalk-Engine-Core'
}

{ #category : #'instance creation' }
VDMJProcess class >> bank: anInteger [
	| bank |
	bank := ViennaBankEngine new.
	anInteger timesRepeat: [ bank add: self new ].
	^ bank
]

{ #category : #accessing }
VDMJProcess class >> javaPath [
	^ '/usr/bin/java'
]

{ #category : #'instance creation' }
VDMJProcess class >> new [
	| process |
	process := super new.
	self register: process.
	^ process
]

{ #category : #registry }
VDMJProcess class >> register: aVDMJProcess [
	^ self registry add: aVDMJProcess
]

{ #category : #registry }
VDMJProcess class >> registry [
	^ Registry ifNil: [Registry := WeakRegistry new]
]

{ #category : #registry }
VDMJProcess class >> unregister: aVDMJProcess [
	^ self registry remove: aVDMJProcess ifAbsent: []
]

{ #category : #testing }
VDMJProcess class >> vdmjInstalled [
	^ FileStream isAFileNamed: VDMJProcess vdmjPath
]

{ #category : #accessing }
VDMJProcess class >> vdmjPath [
	^ 'vdmj-3.0.1.jar'
]

{ #category : #accessing }
VDMJProcess class >> vdmpadPath [
	^ 'VDMPad.jar'
]

{ #category : #finalizing }
VDMJProcess >> actAsExecutor [
	lock := nil
]

{ #category : #commands }
VDMJProcess >> assign: aDictionary ifError: errorBlock [ 
	aDictionary
		ifNotEmpty: [| statement |
			statement := String new writeStream.
			statement nextPutAll: 's atomic('.
			aDictionary keys asArray
				do: [:var | statement nextPutAll: var;
						 nextPutAll: ':=';
						
						nextPutAll: (aDictionary at: var)]
				separatedBy: [statement nextPut: $;].
			statement nextPut: $).
			^ self
				send: statement contents
				responseDo: [:unit | unit]
				ifError: errorBlock]
]

{ #category : #commands }
VDMJProcess >> classicIfError: errorBlock [ 
	^ self
		send: 'classic'
		responseDo: [:unit | unit]
		ifError: errorBlock
]

{ #category : #accessing }
VDMJProcess >> close [
	process
		ifNotNilDo: [:p | 
			process := nil.
			p sigterm.
			p sigkill.
			p terminate].
	reader
		ifNotNilDo: [:r | 
			reader := nil.
			r close].
	writer
		ifNotNilDo: [:w | 
			writer := nil.
			w close].
	executor ifNotNil: [self updateExecutor]
]

{ #category : #commands }
VDMJProcess >> default: aString ifError: errorBlock [ 
	^ self
		send: 'default ' , aString
		responseDo: [:module | module]
		ifError: errorBlock
]

{ #category : #commands }
VDMJProcess >> disableRuntimeCheckingIfError: errorBlock [ 
	^ self
		send: '-rtc'
		responseDo: [:unit | unit]
		ifError: errorBlock
]

{ #category : #commands }
VDMJProcess >> enableRuntimeCheckingIfError: errorBlock [ 
	^ self
		send: '+rtc'
		responseDo: [:unit | unit]
		ifError: errorBlock
]

{ #category : #private }
VDMJProcess >> ensureStartupProcess [
	(reader isNil
			or: [reader closed
					or: [process isNil
							or: [process isRunning not]]])
		ifTrue: [self startupProcess]
]

{ #category : #evaluating }
VDMJProcess >> evaluate: expression specification: specification states: states vdm10: vdm10 rtc: rtc [ 
	lock
		critical: [| errorMessage hasModules value postState |
			self ensureStartupProcess.
			self
				temporaryFileDo: [:stream | 
					stream ascii.
					stream lineEndConvention: #lf.
					stream nextPutAll: specification.
					stream close.
					vdm10 = true
						ifTrue: [self
								vdm10IfError: [:msg | ^ {nil. states. msg}]]
						ifFalse: [self
								classicIfError: [:msg | ^ {nil. states. msg}]].
					rtc = true
						ifTrue: [self
								enableRuntimeCheckingIfError: [:msg | ^ {nil. states. msg}]]
						ifFalse: [self
								disableRuntimeCheckingIfError: [:msg | ^ {nil. states. msg}]].
					self
						load: stream name
						ifError: [:msg | ^ {nil. states. msg}]].
			errorMessage := String new writeStream.
			hasModules := false.
			self
				modulesDo: [:module | states
						at: module
						ifPresent: [:bindings | 
							| initBindings |
							hasModules := true.
							self
								default: module
								ifError: [:msg | ^ {nil. states. msg}].
							initBindings := Dictionary new.
							self
								statesDo: [:var :val | initBindings
										at: var
										put: (bindings
												at: var
												ifAbsent: [val])]
								ifError: [:msg | ^ {nil. states. msg}].
							self
								assign: initBindings
								ifError: [:msg | errorMessage nextPutAll: msg;
										 cr]]]
				ifError: [:msg | ^ {nil. states. msg}].
			self
				default: 'DEFAULT'
				ifError: [:msg | ].
			errorMessage contents
				ifNotEmpty: [:msg | ^ {nil. states. msg}].
			value := expression
						ifEmpty: [String new]
						ifNotEmpty: [self
								print: expression
								ifError: [:msg | ^ {nil. states. msg}]].
			postState := Dictionary new.
			self
				modulesDo: [:module | 
					| bindings |
					postState at: module put: (bindings := Dictionary new).
					self
						default: module
						ifError: [:msg | ^ {nil. states. msg}].
					self
						statesDo: [:var :val | bindings at: var put: val]
						ifError: [:msg | ^ {nil. states. msg}]]
				ifError: [:msg | ^ {nil. states. msg}].
			^ {value. postState. String new}]
]

{ #category : #finalizing }
VDMJProcess >> executor [
	^ executor ifNil: [executor := super executor]
]

{ #category : #finalizing }
VDMJProcess >> finalize [
	self close
]

{ #category : #private }
VDMJProcess >> forkProcess: desc [ 
	^ UnixProcess
		forkJob: self javaPath
		arguments: {'-Dfile.encoding=whatever'. '-jar'.
				(FileStream fullName: 'VDMPad.jar')}
		environment: nil
		descriptors: desc
]

{ #category : #'initialize-release' }
VDMJProcess >> initialize [
	super initialize.
	lock := Semaphore forMutualExclusion
]

{ #category : #accessing }
VDMJProcess >> javaPath [
	^ self class javaPath
]

{ #category : #commands }
VDMJProcess >> load: aString ifError: errorBlock [ 
	^ self
		send: 'load ' , aString
		responseDo: [:filename | filename]
		ifError: errorBlock
]

{ #category : #commands }
VDMJProcess >> modulesDo: aBlock ifError: errorBlock [ 
	^ self
		send: 'modules'
		responseDo: [:modules | modules do: aBlock]
		ifError: errorBlock
]

{ #category : #commands }
VDMJProcess >> print: aString ifError: errorBlock [ 
	^ self
		send: 'print ' , aString
		responseDo: [:filename | filename]
		ifError: errorBlock
]

{ #category : #communicating }
VDMJProcess >> send: aString responseDo: aBlock ifError: errorBlock [
	| semaphore response readerProcess |
	(reader next: 1024) ifNotEmpty: [:str | Transcript cr; show: str].
	writer nextPutAll: (aString convertToEncoding: 'utf-8').
	writer nextPut: Character lf.
	writer flush.
	semaphore := Semaphore new.
	response := String new writeStream.
	readerProcess := [[reader next
				ifNil: [(Delay forMilliseconds: 5) wait.
					true]
				ifNotNil: [:char | char = Character lf
						ifTrue: [semaphore signal.
							false]
						ifFalse: [response nextPut: char.
							true]]] whileTrue]
				forkAt: Processor userBackgroundPriority.
	^ (semaphore waitTimeoutMSecs: 10000)
		ifTrue: [readerProcess terminate.
			self close.
			self startupProcess.
			errorBlock value: 'Time out']
		ifFalse: [response := NeoJSONReader
						fromString: (response contents convertFromEncoding: 'utf-8').
			(response first = true
				ifTrue: [aBlock]
				ifFalse: [errorBlock])
				value: response second]
]

{ #category : #private }
VDMJProcess >> setProcess: anExternalProcess [
	process := anExternalProcess
]

{ #category : #private }
VDMJProcess >> setReader: aPipe [
	reader := aPipe
]

{ #category : #private }
VDMJProcess >> setWriter: aPipe [
	writer := aPipe
]

{ #category : #private }
VDMJProcess >> startupProcess [
	| pipe1 pipe2 input output desc |
	OSProcess accessor canAccessSystem
		ifFalse: [ ^ nil ].
	pipe1 := OSPipe blockingPipe.
	pipe2 := OSPipe nonBlockingPipe.
	input := pipe1 reader.
	output := pipe2 writer.
	writer := pipe1 writer.
	reader := pipe2 reader.
	desc := Array with: input with: output with: output.
	process := self forkProcess: desc.
	input close.
	output close.
	self updateExecutor
]

{ #category : #commands }
VDMJProcess >> statesDo: aBlock ifError: errorBlock [ 
	^ self
		send: 'state'
		responseDo: [:stateDict | stateDict
				keysAndValuesDo: [:var :value | (value beginsWithEmpty: 'mk_' , var caseSensitive: true)
						ifFalse: [aBlock value: var value: value]]]
		ifError: errorBlock
]

{ #category : #private }
VDMJProcess >> temporaryFileDo: aBlock [ 
	| random file stream |
	random := Random new.
	[file := FileSystem workingDirectory / 'VDMPad-spec-'
					, (String
							withAll: ((1 to: 8)
									collect: [:i | '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
											at: (random nextInt: 36)])) , '.vdm'.
	file exists] whileTrue.
	stream := file writeStream.
	[aBlock value: stream]
		ensure: [stream close.
			file deleteIfAbsent: []]
]

{ #category : #finalizing }
VDMJProcess >> updateExecutor [
	self executor setProcess: process.
	self executor setReader: reader.
	self executor setWriter: writer
]

{ #category : #commands }
VDMJProcess >> vdm10IfError: errorBlock [ 
	^ self
		send: 'vdm10'
		responseDo: [:unit | unit]
		ifError: errorBlock
]

{ #category : #accessing }
VDMJProcess >> vdmjPath [
	^ self class vdmjPath
]
