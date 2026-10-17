Class {
	#name : 'ViennaFeedApplication',
	#superclass : 'ClapApplication',
	#instVars : [
		'_poolDirectory',
		'_pollingInterval',
		'lastModificationTime',
		'engine'
	],
	#category : 'ViennaTalk-Application',
	#package : 'ViennaTalk-Application'
}

{ #category : 'accessing' }
ViennaFeedApplication class >> commandName [

	^ 'feed'
]

{ #category : 'commandline' }
ViennaFeedApplication class >> feed [

	<commandline>
	^ (ClapCommandSpec id: self commandName asSymbol)
		  addPositional: #poolDirectory
		  description: 'A fullpath to the pool directory to fetch <taskid>.request and write <taskid>.response';
		  addFlagWithPositional: #interval
		  description: 'The polling interval in milli-seconds to fetch a new request in the pool directory';
		  description: 'A worker process for evaluation and execution of VDM-SL';
		  commandClass: self;
		  addHelp;
		  yourself
]

{ #category : 'accessing' }
ViennaFeedApplication class >> inprogressExtension [

	^ 'inprogress'
]

{ #category : 'accessing' }
ViennaFeedApplication class >> requestExtension [

	^ 'request'
]

{ #category : 'accessing' }
ViennaFeedApplication class >> responseExtension [

	^ 'response'
]

{ #category : 'running' }
ViennaFeedApplication class >> run: aFileReference [

	| vm image |
	vm := Smalltalk vm fullPath.
	image := Smalltalk imagePath.
	RMDLibC spawn: {
			vm.
			'--headless'.
			image.
			self commandName.
			(aFileReference
				 ensureCreateDirectory;
				 fullName) }
]

{ #category : 'accessing' }
ViennaFeedApplication class >> withInprogressExtension: aFileReference [

	^ aFileReference withExtension: self inprogressExtension
]

{ #category : 'accessing' }
ViennaFeedApplication class >> withRequestExtension: aFileReference [

	^ aFileReference withExtension: self requestExtension
]

{ #category : 'accessing' }
ViennaFeedApplication class >> withResponseExtension: aFileReference [

	^ aFileReference withExtension: self responseExtension
]

{ #category : 'defaults' }
ViennaFeedApplication >> defaultPollingInterval [

	^ 100
]

{ #category : 'execution' }
ViennaFeedApplication >> evaluate: aString specification: anotherString states: aDictionary module: yetAnotherString [

	^ engine
		  evaluate: aString
		  specification: anotherString
		  states: aDictionary
		  module: yetAnotherString
]

{ #category : 'execution' }
ViennaFeedApplication >> execute [

	[ self poolDirectory isDirectory ] whileTrue: [ self oneCycle ]
]

{ #category : 'execution' }
ViennaFeedApplication >> fetchRequest [

	(lastModificationTime isNil or: [ lastModificationTime < self poolDirectory modificationTime ]) ifTrue: [
			| id |
			id := nil.
			(self poolDirectory filesMatching: '*.' , self class requestExtension) do: [ :ref |
					(self withInprogressExtension: ref) exists ifFalse: [
							id ifNil: [
									[
										id := self poolDirectory / UUID new asInteger asString.
										id exists ] whileTrue.
									id ensureCreateFile ].
							([ id renameTo: (self withInprogressExtension: ref) ]
								 on: FileExists
								 do: [ :ex | ex return: nil ]) ifNotNil: [ ^ ref ] ] ].
			id ifNotNil: [ id ensureDelete ] ].
	^ nil
]

{ #category : 'execution' }
ViennaFeedApplication >> oneCycle [

	self fetchRequest ifNotNil: [ :request | self process: request ] ifNil: [ self wait ]
]

{ #category : 'accessing' }
ViennaFeedApplication >> pollingInterval [

	^ _pollingInterval ifNil: [
			  _pollingInterval := ((self
				                        positional: #interval
				                        ifPresent: [ :str |
						                        (str allSatisfy: #digit)
							                        ifTrue: [ str asInteger ]
							                        ifFalse: [ nil ] ]
				                        ifAbsent: [ nil ]) ifNil: [ self defaultPollingInterval ]) milliSeconds ]
]

{ #category : 'accessing' }
ViennaFeedApplication >> poolDirectory [

	^ _poolDirectory ifNil: [ _poolDirectory := (self positional: #poolDirectory) asFileReference ]
]

{ #category : 'execution' }
ViennaFeedApplication >> process: aFileReference [

	| request source expression preStates module result response |
	request := aFileReference readStreamDo: [ :stream | STONJSON fromStream: stream ].
	source := request at: 'source' ifAbsent: [ String new ].
	expression := request at: 'expression' ifAbsent: [ String new ].
	preStates := Dictionary new: request size.
	request keysAndValuesDo: [ :key :value |
			(key includes: $`) ifTrue: [
					| index moduleName var |
					index := key indexOf: $`.
					moduleName := key copyFrom: 1 to: index - 1.
					var := key copyFrom: index + 1 to: key size.
					(preStates at: moduleName ifAbsentPut: [ Dictionary new ]) at: var put: value ] ].
	module := request at: 'module' ifAbsent: [ 'DEFAULT' ].
	result := self
		          evaluate: expression
		          specification: source
		          states: preStates
		          module: module.
	response := Dictionary new.
	response
		at: 'source' put: source;
		at: 'expression' put: expression;
		at: 'value' put: (result first ifNil: [ String new ]);
		at: 'message' put: result third.
	result second keysAndValuesDo: [ :moduleName :bindings |
		bindings keysAndValuesDo: [ :varName :value | response at: moduleName , '`' , varName put: value ] ].
	^ (self withResponseExtension: aFileReference)
		  writeStreamDo: [ :stream | STONJSON put: response onStream: stream ];
		  yourself
]

{ #category : 'delaying' }
ViennaFeedApplication >> wait [

	^ self pollingInterval wait
]

{ #category : 'accessing' }
ViennaFeedApplication >> withInprogressExtension: ref [

	^ self class withInprogressExtension: ref
]

{ #category : 'accessing' }
ViennaFeedApplication >> withRequestExtension: ref [

	^ self class withRequestExtension: ref
]

{ #category : 'accessing' }
ViennaFeedApplication >> withResponseExtension: ref [

	^ self class withResponseExtension: ref
]
