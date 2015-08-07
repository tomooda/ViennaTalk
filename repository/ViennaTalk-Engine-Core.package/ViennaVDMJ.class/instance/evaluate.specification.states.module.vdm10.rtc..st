evaluating
evaluate: expression specification: specification states: states module: moduleName vdm10: vdm10 rtc: rtc
	lock
		critical: [ 
			| errorMessage hasModules value postState |
			self ensureStartupProcess.
			self
				temporaryFileDo: [ :stream | 
					stream ascii.
					stream lineEndConvention: #lf.
					stream nextPutAll: specification.
					stream close.
					vdm10 = true
						ifTrue: [ 
							self
								vdm10IfError: [ :msg | 
									^ {nil.
									states.
									msg} ] ]
						ifFalse: [ 
							self
								classicIfError: [ :msg | 
									^ {nil.
									states.
									msg} ] ].
					rtc = true
						ifTrue: [ 
							self
								enableRuntimeCheckingIfError: [ :msg | 
									^ {nil.
									states.
									msg} ] ]
						ifFalse: [ 
							self
								disableRuntimeCheckingIfError: [ :msg | 
									^ {nil.
									states.
									msg} ] ].
					self
						load: stream name
						ifError: [ :msg | 
							^ {nil.
							states.
							msg} ] ].
			errorMessage := String new writeStream.
			hasModules := false.
			self
				modulesDo: [ :module | 
					states
						at: module
						ifPresent: [ :bindings | 
							| initBindings |
							hasModules := true.
							self
								default: module
								ifError: [ :msg | 
									^ {nil.
									states.
									msg} ].
							initBindings := Dictionary new.
							self
								statesDo: [ :var :val | initBindings at: var put: (bindings at: var ifAbsent: [ val ]) ]
								ifError: [ :msg | 
									^ {nil.
									states.
									msg} ].
							self
								assign: initBindings
								ifError: [ :msg | 
									errorMessage
										nextPutAll: msg;
										cr ] ] ]
				ifError: [ :msg | 
					^ {nil.
					states.
					msg} ].
			self
				default: moduleName
				ifError: [ :msg | 
					^ {nil.
					states.
					msg} ].
			errorMessage contents
				ifNotEmpty: [ :msg | 
					^ {nil.
					states.
					msg} ].
			value := expression
				ifEmpty: [ String new ]
				ifNotEmpty: [ 
					self
						print: expression
						ifError: [ :msg | 
							^ {nil.
							states.
							msg} ] ].
			postState := Dictionary new.
			self
				modulesDo: [ :module | 
					| bindings |
					postState at: module put: (bindings := Dictionary new).
					self
						default: module
						ifError: [ :msg | 
							^ {nil.
							states.
							msg} ].
					self
						statesDo: [ :var :val | bindings at: var put: val ]
						ifError: [ :msg | 
							^ {nil.
							states.
							msg} ] ]
				ifError: [ :msg | 
					^ {nil.
					states.
					msg} ].
			^ {value.
			postState.
			(String new)} ]