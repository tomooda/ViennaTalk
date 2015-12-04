parsers-statements
identityStatement
	^ (self reserved: 'skip') ==> [ :string | nil ]