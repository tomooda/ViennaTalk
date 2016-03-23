request handling
frontPage
	^ self
		responseOk:
			(ZnStringEntity
				html:
					'<!DOCTYPE html>
<html>
<head><meta charset="UTF-8">
<title>Webly Walk-Through</title>
</head>
<body>
Webly Walk-Through is running.
</body></html>')