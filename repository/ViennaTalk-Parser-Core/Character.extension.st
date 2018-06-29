Extension { #name : #Character }

{ #category : #'*ViennaTalk-Parser-Core' }
Character >> isSeparator [
	"Answer whether the receiver is one of the separator characters--space, 
	cr, tab, line feed, or form feed."

	value = 32
		ifTrue: [ ^ true ].	"space"
	value = 13
		ifTrue: [ ^ true ].	"cr"
	value = 9
		ifTrue: [ ^ true ].	"tab"
	value = 10
		ifTrue: [ ^ true ].	"line feed"
	value = 12
		ifTrue: [ ^ true ].	"form feed"
	value = 12288
		ifTrue: [ ^ true ].	"IDEOGRAPHIC SPACE (aka full-width space in CJK)"
	^ false
]
