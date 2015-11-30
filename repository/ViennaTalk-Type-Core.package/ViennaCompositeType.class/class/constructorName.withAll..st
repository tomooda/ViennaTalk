instance creation
constructorName: aString withAll: anArrayOfFieldNameAndEqualityAbstractionAndType
	| composite |
	composite := self new: anArrayOfFieldNameAndEqualityAbstractionAndType size.
	composite setConstructorName: aString.
	1 to: anArrayOfFieldNameAndEqualityAbstractionAndType size do: [ :index | composite at: index put: (anArrayOfFieldNameAndEqualityAbstractionAndType at: index) ].
	^ composite