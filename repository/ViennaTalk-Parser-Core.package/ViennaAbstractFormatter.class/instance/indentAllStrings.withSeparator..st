private
indentAllStrings: anArrayOfString withSeparator: separator
	^ separator , String cr , indent join: (anArrayOfString collect: [ :string | self indentString: string ])