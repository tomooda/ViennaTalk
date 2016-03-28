private
indentString: aString insertCr: anotherString
	^ anotherString ifEmpty: [ aString ] ifNotEmpty: [ aString , String cr , indent , (self indentString: anotherString) ]