parsers-expressions
casesExpressionAlternatives
	^ (self casesExpressionAlternative separatedBy: (self keyword: comma)) withoutSeparators