Class {
	#name : #ViennaVDMJ,
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
ViennaVDMJ class >> bank: anInteger [
	| bank |
	bank := ViennaBankEngine new.
	anInteger timesRepeat: [ bank add: self new ].
	^ bank
]

{ #category : #accessing }
ViennaVDMJ class >> javaPath [
	^ '/usr/bin/java'
]

{ #category : #'instance creation' }
ViennaVDMJ class >> new [
	| process |
	process := super new.
	self register: process.
	^ process
]

{ #category : #registry }
ViennaVDMJ class >> register: aViennaVDMJ [
	^ self registry add: aViennaVDMJ
]

{ #category : #registry }
ViennaVDMJ class >> registry [
	^ Registry ifNil: [Registry := WeakRegistry new]
]

{ #category : #registry }
ViennaVDMJ class >> unregister: aViennaVDMJ [
	^ self registry remove: aViennaVDMJ ifAbsent: []
]

{ #category : #testing }
ViennaVDMJ class >> vdmjInstalled [
	^ FileStream isAFileNamed: ViennaVDMJ vdmjPath
]

{ #category : #accessing }
ViennaVDMJ class >> vdmjPath [
	^ 'vdmj-3.0.1.jar'
]

{ #category : #accessing }
ViennaVDMJ class >> vdmpadPath [
	^ 'VDMPad.jar'
]

{ #category : #finalizing }
ViennaVDMJ >> actAsExecutor [
	lock := nil
]

{ #category : #commands }
ViennaVDMJ >> assign: aDictionary ifError: errorBlock [ 
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
ViennaVDMJ >> classicIfError: errorBlock [ 
	^ self
		send: 'classic'
		responseDo: [:unit | unit]
		ifError: errorBlock
]

{ #category : #accessing }
ViennaVDMJ >> close [
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
ViennaVDMJ >> default: aString ifError: errorBlock [ 
	^ self
		send: 'default ' , aString
		responseDo: [:module | module]
		ifError: errorBlock
]

{ #category : #commands }
ViennaVDMJ >> disableRuntimeCheckingIfError: errorBlock [ 
	^ self
		send: '-rtc'
		responseDo: [:unit | unit]
		ifError: errorBlock
]

{ #category : #commands }
ViennaVDMJ >> enableRuntimeCheckingIfError: errorBlock [ 
	^ self
		send: '+rtc'
		responseDo: [:unit | unit]
		ifError: errorBlock
]

{ #category : #private }
ViennaVDMJ >> ensureStartupProcess [
	(reader isNil
			or: [reader closed
					or: [process isNil
							or: [process isRunning not]]])
		ifTrue: [self startupProcess]
]

{ #category : #evaluating }
ViennaVDMJ >> evaluate: expression specification: specification states: states vdm10: vdm10 rtc: rtc [ 
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
ViennaVDMJ >> executor [
	^ executor ifNil: [executor := super executor]
]

{ #category : #finalizing }
ViennaVDMJ >> finalize [
	self close
]

{ #category : #private }
ViennaVDMJ >> forkProcess: desc [ 
	^ UnixProcess
		forkJob: self javaPath
		arguments: {'-Dfile.encoding=whatever'. '-jar'.
				(FileStream fullName: 'VDMPad.jar')}
		environment: nil
		descriptors: desc
]

{ #category : #'initialize-release' }
ViennaVDMJ >> initialize [
	super initialize.
	lock := Semaphore forMutualExclusion
]

{ #category : #accessing }
ViennaVDMJ >> javaPath [
	^ self class javaPath
]

{ #category : #commands }
ViennaVDMJ >> load: aString ifError: errorBlock [ 
	^ self
		send: 'load ' , aString
		responseDo: [:filename | filename]
		ifError: errorBlock
]

{ #category : #commands }
ViennaVDMJ >> modulesDo: aBlock ifError: errorBlock [ 
	^ self
		send: 'modules'
		responseDo: [:modules | modules do: aBlock]
		ifError: errorBlock
]

{ #category : #commands }
ViennaVDMJ >> print: aString ifError: errorBlock [ 
	^ self
		send: 'print ' , aString
		responseDo: [:filename | filename]
		ifError: errorBlock
]

{ #category : #communicating }
ViennaVDMJ >> send: aString responseDo: aBlock ifError: errorBlock [
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
ViennaVDMJ >> setProcess: anExternalProcess [
	process := anExternalProcess
]

{ #category : #private }
ViennaVDMJ >> setReader: aPipe [
	reader := aPipe
]

{ #category : #private }
ViennaVDMJ >> setWriter: aPipe [
	writer := aPipe
]

{ #category : #private }
ViennaVDMJ >> startupProcess [
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
ViennaVDMJ >> statesDo: aBlock ifError: errorBlock [ 
	^ self
		send: 'state'
		responseDo: [:stateDict | stateDict
				keysAndValuesDo: [:var :value | (value beginsWithEmpty: 'mk_' , var caseSensitive: true)
						ifFalse: [aBlock value: var value: value]]]
		ifError: errorBlock
]

{ #category : #private }
ViennaVDMJ >> temporaryFileDo: aBlock [ 
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
ViennaVDMJ >> updateExecutor [
	self executor setProcess: process.
	self executor setReader: reader.
	self executor setWriter: writer
]

{ #category : #commands }
ViennaVDMJ >> vdm10IfError: errorBlock [ 
	^ self
		send: 'vdm10'
		responseDo: [:unit | unit]
		ifError: errorBlock
]

{ #category : #accessing }
ViennaVDMJ >> vdmjPath [
	^ self class vdmjPath
]
