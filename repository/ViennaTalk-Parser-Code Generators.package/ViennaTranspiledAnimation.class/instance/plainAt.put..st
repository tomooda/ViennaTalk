accessing
plainAt: aString put: aVDMString
	^ self at: aString put: (reader parse: aVDMString)