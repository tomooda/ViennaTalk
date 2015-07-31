class initialization
installVDMJ
	"VDMPad installVDMJ"

	| http |
	http := ZnClient new.
	http
		beOneShot;
		https;
		followRedirects: true;
		get: self vdmjUrl.
	(FileSystem workingDirectory / 'vdmj-3.0.1.jar') writeStream
		nextPutAll: http entity bytes;
		close