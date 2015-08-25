class initialization
installJsonic
	"ViennaVDMJ installJsonic"

	(FileSystem workingDirectory / 'jsonic-1.0.5.jar') writeStream
		nextPutAll: self jsonicJar;
		close