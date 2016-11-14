accessing
specification: aString ifError: errorBlock
	specification ~= aString
		ifTrue: [ 
			| oldState |
			lock
				critical: [ 
					| oldSpec |
					oldSpec := specification.
					oldState := state copy.
					specification := aString.
					self
						basicPlainEvaluate: 'nil'
						in: self defaultModule
						ifError: [ :msg | 
							specification := oldSpec.
							^ errorBlock cull: msg ] ].
			self changed: #specification.
			oldState ~= state
				ifTrue: [ self changed: #state ] ]