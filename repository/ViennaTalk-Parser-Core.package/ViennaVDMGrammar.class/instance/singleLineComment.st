parsers-comments
singleLineComment
	^ ('--' asParser , (Character cr asParser not , #any asParser) star) trim plus flatten
		==> [ :str | self trimComment: str ]