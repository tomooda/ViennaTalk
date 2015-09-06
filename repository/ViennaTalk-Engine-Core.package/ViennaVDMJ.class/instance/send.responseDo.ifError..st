communicating
send: aString responseDo: aBlock ifError: errorBlock
	| semaphore response readerProcess |
	(reader next: 1024) ifNotEmpty: [:str | Transcript cr; show: str].
	writer nextPutAll: (aString convertToEncoding: 'utf-8').
	writer nextPut: Character lf.
	writer flush.
	semaphore := Semaphore new.
	response := String new writeStream.
	readerProcess := [[reader next
				ifNil: ["(Delay forMilliseconds: 5) wait."Processor yield.
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