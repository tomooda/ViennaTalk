private
newlineIndentString: aString
	^ String cr , indent , (self indentString: aString)