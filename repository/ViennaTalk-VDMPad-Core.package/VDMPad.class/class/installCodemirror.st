class initialization
installCodemirror
	"VDMPad installCodemirror"

	ZipArchive new
		readFrom: self codemirrorZip readStream;
		extractAllTo: FileSystem workingDirectory