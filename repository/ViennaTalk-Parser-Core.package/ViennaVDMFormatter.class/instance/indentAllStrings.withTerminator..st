private
indentAllStrings: anArrayOfString withTerminator: terminator
	^ (self indentAllStrings: anArrayOfString withSeparator: terminator) , terminator