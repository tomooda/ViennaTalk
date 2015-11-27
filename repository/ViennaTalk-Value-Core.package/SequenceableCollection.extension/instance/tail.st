*ViennaTalk-Value-Core
tail
	^ self ifEmpty: [ SubscriptOutOfBounds signal ] ifNotEmpty: [ self copyFrom: 2 to: self size ]