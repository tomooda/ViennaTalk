private
newlineIndentAllStrings: anArrayOfString
	^ String new join: (anArrayOfString collect: [ :string | self newlineIndentString: string ])