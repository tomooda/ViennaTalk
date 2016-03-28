private
indentAllStrings: anArrayOfString
	^ String cr , indent join: (anArrayOfString collect: [ :string | self indentString: string ])