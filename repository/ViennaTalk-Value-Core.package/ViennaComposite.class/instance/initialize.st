initialize-release
initialize
	super initialize.
	namedFields := Dictionary new.
	equalityFields := (1 to: self size) asArray