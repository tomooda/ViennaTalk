parsing
parseQuoteOn: aStream
	| quote |
	(aStream nextMatchAll: '<')
		ifFalse: [ ^ self error: 'expected <' ].
	quote := aStream upTo: $>.
	(quote allSatisfy: #isLetter)
		ifFalse: [ ^ self error: 'Invalid char in quote' ].
	^ specials at: #<> ifPresent: [ :block | block value: quote ] ifAbsent: [ quote asSymbol ]