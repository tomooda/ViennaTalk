accessing
director
	| director |
	director := self.
	[ director isNil or: [ director isKindOf: LWTDirector ] ] whileFalse: [ director := director owner ].
	^ director