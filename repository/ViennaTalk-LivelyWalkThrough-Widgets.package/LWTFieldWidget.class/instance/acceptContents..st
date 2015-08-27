accessing
acceptContents: aStringOrText
	| oldContents |
	oldContents := contents.
	^ self
		validate: aStringOrText asString
		do: [ :validString | 
			contents := validString.
			contents ~= oldContents
				ifTrue: [ self event: #changed ].
			true ]
		ifError: [ false ]