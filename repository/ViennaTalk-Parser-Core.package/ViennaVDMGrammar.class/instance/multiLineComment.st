parsers-comments
multiLineComment
	^ ('/*' asParser , ('*/' asParser not , #any asParser) star , '*/' asParser) trim plus flatten
		==> [ :str | self trimComment: str ]