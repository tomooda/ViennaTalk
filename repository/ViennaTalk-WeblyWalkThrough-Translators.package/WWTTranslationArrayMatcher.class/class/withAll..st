instance creation
withAll: anArrayOfWWTTranslationMatcher
	^ self new
		elementMatchers: anArrayOfWWTTranslationMatcher;
		yourself