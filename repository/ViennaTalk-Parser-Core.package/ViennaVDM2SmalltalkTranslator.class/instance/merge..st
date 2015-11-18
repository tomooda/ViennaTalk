parsers-expressions-operators
merge: setOfDict
	^ '(' , setOfDict , ' in: [:s | | d | d := Dictionary new. s do: [:d1 | d addAll: d1]. d])'