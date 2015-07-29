initialize-release
initialize
	super initialize.
	engines := OrderedCollection new.
	ringBufferIndex := 0