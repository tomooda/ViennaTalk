Trait {
	#name : #TViennaVDMLiteralParser,
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> booleanLiteral [
	^ ((('true' asPParser , self endOfWord) ==> [ :t | true ]) / (('false' asPParser , self endOfWord) ==> [ :t | false ]))
		trim
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> char [
	^ self escapeSequence / (($" asPParser not , $' asPParser not , #any asPParser) ==> #third)
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> characterLiteral [
	^ (($' asPParser , (self char / $" asPParser) , $' asPParser) ==> #second) trim
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> decimalLiteral [
	^ (#digit asPParser plusA , ((self operator: $.) , #digit asPParser plusA) optional
		, ($e asPParser / $E asPParser , ($+ asPParser / $- asPParser) optional , #digit asPParser plusA) optional) flatten trim
		==> #asLowercase
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> endOfWord [
	^ (PP2PredicateObjectNode  on: [ :c | ViennaUnicode isFollowingLetter: c ] message: 'identifier expected') not
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> escapeSequence [
	| octal |
	octal := $0 asPParser / $1 asPParser / $2 asPParser / $3 asPParser / $4 asPParser / $5 asPParser / $6 asPParser / $7 asPParser.
	^ ($\ asPParser
		,
			(($\ asPParser ==> [ :c | $\ ]) / ($r asPParser ==> [ :c | Character cr ]) / ($n asPParser ==> [ :c | Character lf ])
				/ ($t asPParser ==> [ :c | Character tab ]) / ($f asPParser ==> [ :c | Character newPage ])
				/ ($e asPParser ==> [ :c | Character escape ]) / ($a asPParser ==> [ :c | Character value: 7 ])
				/
					(($x asPParser , #hex asPParser , #hex asPParser)
						==> [ :triple | Character value: (triple second digitValue << 4) + triple third digitValue ])
				/
					(($u asPParser , #hex asPParser , #hex asPParser , #hex asPParser , #hex asPParser)
						==> [ :quin | 
							Character
								value:
									(quin second digitValue << 12) + (quin third digitValue << 8) + (quin fourth digitValue << 4) + quin fifth digitValue ])
				/ (($c asPParser , #any asPParser) ==> [ :pair | Character value: pair second asLowercase charCode - $a + 1 ])
				/
					((octal , octal , octal)
						==> [ :triple | Character value: (triple first digitValue << 6) + (triple second digitValue << 3) + triple third digitValue ])
				/ ($" asPParser ==> [ :c | $" ]) / ($' asPParser ==> [ :c | $' ]))) ==> #second
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> hexadecimalLiteral [
	^ (('0x' asPParser / '0X' asPParser , #hex asPParser plusA flatten)
		==> #second) trim
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> nilLiteral [
	^ ('nil' asPParser , self endOfWord) trim ==> [ :t | nil ]
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> numericLiteral [
	^ self hexadecimalLiteral / self decimalLiteral
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> quoteLiteral [
	^ ($< asPParser
		,
			((PP2PredicateObjectNode
				on: [ :c | ViennaUnicode isInitialLetter: c ]
				message: 'identifier expected')
				,
					(PP2PredicateObjectNode
						on: [ :c | ViennaUnicode isFollowingLetter: c ]
						message: 'identifier expected') starA) , $> asPParser) flatten trim
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> symbolicLiteral [
	^ self numericLiteral / self booleanLiteral / self nilLiteral / self characterLiteral / self textLiteral
		/ self quoteLiteral
]

{ #category : #'parsers-literals' }
TViennaVDMLiteralParser >> textLiteral [
	^ (($" asPParser
		, ((self char / $' asPParser) starA ==> [ :chars | String withAll: chars ])
		, $" asPParser) ==> #second) trim
]
