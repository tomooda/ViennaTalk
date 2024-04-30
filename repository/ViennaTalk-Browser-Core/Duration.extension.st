Extension { #name : 'Duration' }

{ #category : '*ViennaTalk-Browser-Core' }
Duration >> printRoughly [

	^ String streamContents: [ :stream | self printRoughlyOn: stream ]
]

{ #category : '*ViennaTalk-Browser-Core' }
Duration >> printRoughlyOn: stream [

	| count |
	self negative ifTrue: [
		stream << '- '.
		^ self abs printRoughlyOn: stream ].
	#( #( days 'day' ) #( hours 'hour' ) #( minutes 'min' ) ) do: [
		:each |
		count := (self perform: each first) truncated.
		count > 0 ifTrue: [
			count printWithCommasOn: stream.
			stream
				space;
				<< (each second asPluralBasedOn: count).
			^ self ] ].
	stream << 'now'
]
