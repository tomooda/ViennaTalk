class initialization
installVDMJ
	"ViennaVDMJ installVDMJ"

	| http |
	http := ZnClient new.
	http
		beOneShot;
		https;
		followRedirects: true;
		get: self vdmjUrl.
	http response code = 200
		ifFalse: [ 
			UIManager default
				abort:
					'Failed to download VDMJ. Please download from https://github.com/nickbattle/vdmj/releases and place it at $PHARO/Contents/Resources/ .' ].
	(FileSystem workingDirectory / 'vdmj-3.0.1.jar') writeStream
		nextPutAll: http entity bytes;
		close