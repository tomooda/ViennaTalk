*ViennaTalk-Value-Core
viennaString
	^ String new: 128 streamContents: [ :stream | self viennaStringOn: stream ]