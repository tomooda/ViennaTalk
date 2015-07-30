private
tailerErrorMessage: aString
	| message |
	message := String new writeStream.
	aString linesDo: [ :line |
		| output |
		output := nil.
		(line includesSubString: 'Error') ifTrue: [
			output := line.
			(output includesSubString: 'at line') ifTrue: [
				output := output copyFrom: 1 to: (output size - (output reverse indexOf: $())
			]
		].
		output ifNotNil: [message nextPutAll: output; cr]].
	"^ message contents"
	^ aString