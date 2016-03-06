private
map: aDictionary
	forms := Dictionary new.
	aDictionary keysAndValuesDo: [ :key :imagePath | forms at: key put: (ImageReadWriter formFromFileNamed: imagePath) ]