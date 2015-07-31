class initialization
installVDMPad
	"ViennaVDMJ installVDMPad"

	(FileSystem workingDirectory / 'VDMPad.jar') writeStream
		nextPutAll: self vdmpadJar;
		close.
	(FileSystem workingDirectory / 'jsonic-1.0.5.jar') writeStream
		nextPutAll: self jsonicJar;
		close