instance creation
type: aString withAll: anArray
	| composite |
	composite := self new: anArray size.
	composite setTypeName: aString.
	1 to: anArray size do: [ :index | composite at: index put: (anArray at: index) ].
	^ composite