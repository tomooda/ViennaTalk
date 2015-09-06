private
frames: anArrayOfFrame
	frames := Array new writeStream.
	frames nextPutAll: anArrayOfFrame.
	lastFrame := anArrayOfFrame ifNotEmpty: [ anArrayOfFrame last ] ifEmpty: [ nil ]