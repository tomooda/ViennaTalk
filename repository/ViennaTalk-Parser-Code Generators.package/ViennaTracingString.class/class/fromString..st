instance creation
fromString: aString
	^ super basicNew
		initialize;
		setString: aString