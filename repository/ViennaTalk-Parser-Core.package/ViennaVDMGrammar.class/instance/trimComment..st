parsers-comments
trimComment: aString
	| start end |
	start := 1.
	[ (aString at: start) isSeparator ] whileTrue: [ start := start + 1 ].
	[ start > 1 and: [ (aString at: start) ~= Character cr ] ] whileTrue: [ start := start - 1 ].
	end := aString size.
	[ (aString at: end) isSeparator ] whileTrue: [ end := end - 1 ].	"[ end < aString size and: [ (aString at: end) ~= Character cr ] ] whileTrue: [ end := end + 1 ]."
	^ aString copyFrom: start to: end