*ViennaTalk-Value-Core
subsequenceFrom: anInteger1 to: anInteger2
	^ self copyFrom: (1 max: anInteger1) to: (anInteger2 min: self size)