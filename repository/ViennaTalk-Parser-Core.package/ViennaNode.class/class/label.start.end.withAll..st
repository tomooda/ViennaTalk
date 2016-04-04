instance creation
label: aString start: anInteger1 end: anInteger2 withAll: anArray
	| node |
	node := self new: anArray size.
	node setLabel: aString.
	1 to: anArray size do: [ :index | node at: index put: (anArray at: index) ].
	node start: anInteger1 end: anInteger2.
	^ node