*ViennaTalk-Parser-Core
isSeparator
	"Answer whether the receiver is one of the separator characters--space, 
	cr, tab, line feed, or form feed."

	^ #(32 13 9 10 12 12288) includes: self asciiValue