accessing
director: aLWTDirector
	director ifNotNil: [ director removeDependent: self ].
	director := aLWTDirector.
	director addDependent: self