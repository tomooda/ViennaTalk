private
translate
	| source |
	source := sourceText text asString.
	[ 
	| failure |
	failure := nil.
	targetText
		accept:
			(self
				translate: source
				ifError: [ :error | 
					failure := error.
					'' ])
		notifying: nil.
	failure ifNotNil: [ sourceText text: (source addAttribute: TextColor red from: failure position + 1 to: source size) ] ]
		on: Error
		do: [ :ex | 
			Transcript
				cr;
				show: ex printString ]