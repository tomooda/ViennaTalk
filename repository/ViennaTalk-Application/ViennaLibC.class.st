"
I'm a module defining access to standard LibC. 
I'm available under Linux and OSX.
Under windows I provide similar functionality through the functions defined in msvcrt.dll
"
Class {
	#name : 'ViennaLibC',
	#superclass : 'FFILibrary',
	#classVars : [
		'P_DETACH',
		'P_NOWAIT',
		'P_NOWAITO',
		'P_OVERLAY',
		'P_WAIT'
	],
	#category : 'ViennaTalk-Application',
	#package : 'ViennaTalk-Application'
}

{ #category : 'initialization' }
ViennaLibC class >> initialize [

	P_WAIT := 0.
	P_NOWAIT := 1.
	P_OVERLAY := 2.
	P_NOWAITO := 3.
	P_DETACH := 4
]

{ #category : 'operations' }
ViennaLibC class >> pid [

	^ self uniqueInstance pid
]

{ #category : 'operations' }
ViennaLibC class >> spawn: anArrayOfString [

	^ self uniqueInstance spawn: anArrayOfString
]

{ #category : 'private - accessing' }
ViennaLibC >> macLibraryName [
	^ 'libc.dylib'
]

{ #category : 'operations' }
ViennaLibC >> pid [

	^ OSPlatform current isWindows
		  ifTrue: [ self win32_GetCurrentProcessId ]
		  ifFalse: [ self posix_getpid ]
]

{ #category : 'private - pid' }
ViennaLibC >> posix_getpid [
	"Get PID of current process."

	 ^self ffiCall: #(int getpid(void))
]

{ #category : 'private - spawn' }
ViennaLibC >> posix_spawn: path argv: argv env: env [

	^ self ffiCall: #(int posix_spawn(nil ,  String path , nil , nil , void* argv, void *env))
]

{ #category : 'operations' }
ViennaLibC >> spawn: anArrayOfString [

	self withArgv: anArrayOfString do: [ :argv |
			OSPlatform current isWindows
				ifTrue: [ self win32_spawnvp: P_NOWAIT cmdname: anArrayOfString first argv: argv ]
				ifFalse: [
						self
							withArgv: (Array streamContents: [ :stream |
										 OSEnvironment current keysAndValuesDo: [ :key :value |
												 stream nextPut: ('=' join: {
															  key.
															  value }) ] ])
							do: [ :env | self posix_spawn: anArrayOfString first argv: argv env: env ] ] ]
]

{ #category : 'operations' }
ViennaLibC >> spawn: aFileReference arguments: anArrayOfString [

	| arg0 |
	arg0 := aFileReference fullName.
	self withArgv: (anArrayOfString copyWithFirst: arg0) do: [ :argv |
			OSPlatform current isWindows
				ifTrue: [ self win32_spawnvp: P_NOWAIT cmdname: arg0 argv: argv ]
				ifFalse: [
						self
							withArgv: (Array streamContents: [ :stream |
										 OSEnvironment current keysAndValuesDo: [ :key :value |
												 stream nextPut: ('=' join: {
															  key.
															  value }) ] ])
							do: [ :env | self posix_spawn: arg0 argv: argv env: env ] ] ]
]

{ #category : 'private - accessing' }
ViennaLibC >> unixLibraryName [
	^ 'libc.so.6'
]

{ #category : 'private - accessing' }
ViennaLibC >> win32LibraryName [
	"While this is not a 'libc' properly, msvcrt has the functions we are defining here"
	^ 'msvcrt.dll'
]

{ #category : 'private - pid' }
ViennaLibC >> win32_GetCurrentProcessId [
	"Get PID of current process."

	 ^self ffiCall: #(uint32 GetCurrentProcessId(void))
]

{ #category : 'private - spawn' }
ViennaLibC >> win32_spawnvp: mode cmdname: cmdname argv: argv [

	^ self ffiCall: #(int64 _spawnvp(int mode, String cmdname, void* argv))
]

{ #category : 'private - argv' }
ViennaLibC >> withArgv: strings do: block [

	| externalArray |
	externalArray := FFIExternalArray externalNewType: 'char*' size: strings size + 1.
	strings withIndexDo: [ :string :stringIndex |
			| byteArray externalAddress |
			byteArray := string utf8Encoded.
			externalAddress := ExternalAddress allocate: byteArray size + 1.
			byteArray withIndexDo: [ :byte :byteIndex | externalAddress byteAt: byteIndex put: byte ].
			externalAddress byteAt: byteArray size + 1 put: 0.
			externalArray at: stringIndex put: externalAddress ].
	externalArray at: strings size + 1 put: ExternalAddress null.
	^ [ block value: externalArray ] ensure: [
			  1 to: strings size do: [ :index | (externalArray at: index) free ].
			  externalArray free ]
]
