instance creation
from: aDictionaryOfStringToMatcher
	^ self new
		matchers: (Array withAll: aDictionaryOfStringToMatcher associations);
		yourself