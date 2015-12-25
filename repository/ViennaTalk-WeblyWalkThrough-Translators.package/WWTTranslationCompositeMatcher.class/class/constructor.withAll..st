instance creation
constructor: aString withAll: anArrayOfWWTTranslationMatcher
	^ self new
		constructorName: aString;
		memberMatchers: anArrayOfWWTTranslationMatcher;
		yourself