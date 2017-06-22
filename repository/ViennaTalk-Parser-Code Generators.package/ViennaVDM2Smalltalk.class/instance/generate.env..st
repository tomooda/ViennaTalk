code generation
generate: aViennaNode env: aDictionary
	aViennaNode isString
		ifTrue: [ ^ aViennaNode ].
	aViennaNode ifNil: [ ^ nil ].
	^ (self
		perform: (aViennaNode label uncapitalized , ':env:') asSymbol
		with: aViennaNode
		with: aDictionary)
		in: [ :code | 
			code isString
				ifTrue: [ code asViennaTracingString: aViennaNode ]
				ifFalse: [ code ] ]