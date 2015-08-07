private
setName: nameString performer: anObject source: sourceString notifying: requestor ifFail: errorBlock
	| compiler methodNode |
	self name: nameString.
	performer := anObject.
	source := sourceString.
	compiler := Compiler new.
	compiler
		from: source
		class: performer class
		context: nil
		notifying: requestor.
	methodNode := compiler translate: source readStream noPattern: true ifFail: [ ^ errorBlock value ].
	compiledMethod := compiler interactive
		ifTrue: [ methodNode generateWithSource ]
		ifFalse: [ methodNode generate ]