instance creation
from: aDictionary
	| doc |
	doc := self new.
	aDictionary keysAndValuesDo: [ :key :value | doc at: key put: value ].
	^ doc