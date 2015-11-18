parsers-literals
escapeSequence
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