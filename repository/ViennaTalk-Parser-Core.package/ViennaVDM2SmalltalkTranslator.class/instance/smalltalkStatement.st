parsers-statements
smalltalkStatement
	| backquote |
	backquote := $` asParser.
	^ ((backquote , ((backquote not , #any asParser) ==> #second) star , backquote)
		==> [ :triple | String withAll: triple second ]) trim