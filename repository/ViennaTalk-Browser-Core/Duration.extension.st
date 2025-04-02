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
	{
		{
			[ :d | d days // 365 ].
			'year' }.
		{
			[ :d | d days // 30 ].
			'month' }.
		{ #days. 'day' }.
		{ #hours. 'hour' }.
		{ #minutes. 'min' } } do: [ :each |
		count := (each first value: self) truncated.
		count > 0 ifTrue: [
			count printWithCommasOn: stream.
			stream
				space;
				<< (each second asPluralBasedOn: count).
			^ self ] ].
	stream << 'now'
]
