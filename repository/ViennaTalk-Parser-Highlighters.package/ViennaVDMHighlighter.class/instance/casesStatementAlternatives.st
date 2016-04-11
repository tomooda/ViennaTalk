parsers-statements
casesStatementAlternatives
	^ (self casesStatementAlternative separatedBy: (self keyword: comma)) withoutSeparators