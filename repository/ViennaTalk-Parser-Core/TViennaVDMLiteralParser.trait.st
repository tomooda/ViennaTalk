Trait {
	#name : #TViennaVDMLiteralParser,
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> booleanLiteral [
	^ ((('true' asParser , self endOfWord) ==> [ :t | true ]) / (('false' asParser , self endOfWord) ==> [ :t | false ]))
		trim
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> char [
	^ self escapeSequence / (($" asParser not , $' asParser not , #any asParser) ==> #third)
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> characterLiteral [
	^ (($' asParser , (self char / $" asParser) , $' asParser) ==> #second) trim
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> decimalLiteral [
	^ (#digit asParser plus , ((self operator: $.) , #digit asParser plus) optional
		, ($e asParser / $E asParser , ($+ asParser / $- asParser) optional , #digit asParser plus) optional) flatten trim
		==> #asLowercase
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> endOfWord [
	^ (PPPredicateObjectParser on: [ :c | ViennaUnicode isFollowingLetter: c ] message: 'identifier expected') not
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> escapeSequence [
	| octal |
	octal := $0 asParser / $1 asParser / $2 asParser / $3 asParser / $4 asParser / $5 asParser / $6 asParser / $7 asParser.
	^ ($\ asParser
		,
			(($\ asParser ==> [ :c | $\ ]) / ($r asParser ==> [ :c | Character cr ]) / ($n asParser ==> [ :c | Character lf ])
				/ ($t asParser ==> [ :c | Character tab ]) / ($f asParser ==> [ :c | Character newPage ])
				/ ($e asParser ==> [ :c | Character escape ]) / ($a asParser ==> [ :c | Character value: 7 ])
				/
					(($x asParser , #hex asParser , #hex asParser)
						==> [ :triple | Character value: (triple second digitValue << 4) + triple third digitValue ])
				/
					(($u asParser , #hex asParser , #hex asParser , #hex asParser , #hex asParser)
						==> [ :quin | 
							Character
								value:
									(quin second digitValue << 12) + (quin third digitValue << 8) + (quin fourth digitValue << 4) + quin fifth digitValue ])
				/ (($c asParser , #any asParser) ==> [ :pair | Character value: pair second asLowercase charCode - $a + 1 ])
				/
					((octal , octal , octal)
						==> [ :triple | Character value: (triple first digitValue << 6) + (triple second digitValue << 3) + triple third digitValue ])
				/ ($" asParser ==> [ :c | $" ]) / ($' asParser ==> [ :c | $' ]))) ==> #second
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> hexadecimalLiteral [
	^ (('0x' asParser / '0X' asParser , #hex asParser plus flatten) ==> #second) trim
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> nilLiteral [
	^ ('nil' asParser , self endOfWord) trim ==> [ :t | nil ]
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> numericLiteral [
	^ self hexadecimalLiteral / self decimalLiteral
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> quoteLiteral [
	^ ($< asParser
		,
			((PPPredicateObjectParser on: [ :c | ViennaUnicode isInitialLetter: c ] message: 'identifier expected')
				, (PPPredicateObjectParser on: [ :c | ViennaUnicode isFollowingLetter: c ] message: 'identifier expected') star)
		, $> asParser) flatten trim
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> symbolicLiteral [
	^ self numericLiteral / self booleanLiteral / self nilLiteral / self characterLiteral / self textLiteral
		/ self quoteLiteral
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> textLiteral [
	^ (($" asParser , ((self char / $' asParser) star ==> [ :chars | String withAll: chars ]) , $" asParser) ==> #second)
		trim
]
