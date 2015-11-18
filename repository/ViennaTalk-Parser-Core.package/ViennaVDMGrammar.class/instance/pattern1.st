parsers-patterns
pattern1
	^ self matchValue / self setEnumPattern / self seqEnumPattern / self mapEnumerationPattern / self tuplePattern / self objectPattern / self recordPattern
		/ self patternIdentifier