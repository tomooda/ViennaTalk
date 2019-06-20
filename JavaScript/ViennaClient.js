String.prototype.vienna_eval =
    function(expr, prestates={}) {
	var req = new XMLHttpRequest();
	var json = {"source": this, "expression": expr};
	for (let k in prestates) {
	    var v = prestates[k];
	    if (k.indexOf('`') < 0) {
		k = "DEFAULT`" + k;
	    }
	    json[k] = v;
	}
	req.open("POST", "http://vdmpad.viennatalk.org/eval", false);
	req.setRequestHeader("Content-type", "application/json");
	req.send(JSON.stringify(json));
	var result = JSON.parse(req.responseText);
	var poststates = {};
	for (let k in result) {
	    if (k.indexOf('`') >= 0) {
		var v = result[k];
		delete result[k];
		if (k.indexOf('DEFAULT`') == 0) {
		    k = k.slice(8);
		}
		poststates[k] = v;
	    }
	}
	result.prestates = prestates;
	result.poststates = poststates;
	return result;
    };

function ViennaClient(url="https://vdmpad.viennatalk.org/", async=true) {
    this.url = url;
    this.async = async;
    this.onreadystatechange = null;
    this.onsuccess = null;
    this.onerror = null;
};

ViennaClient.prototype.eval =
    function(expression, source="", prestates={}) {
	this.req = new XMLHttpRequest();
	this.req.open("POST", this.url+"eval", this.async);
	this.req.setRequestHeader("Content-type", "application/json");
	if (this.async) {
	    this.req.onreadystatechange = () => {
		this.readyState = this.req.readyState;
		this.status = this.req.status;
		if (this.req.readyState == 4 && this.req.status == 200) {
		    this.responseText = this.req.responseText;
		    this.response = JSON.parse(this.responseText);
		    var poststates = {};
		    for (let k in this.response) {
			if (k.indexOf('`') > 0) {
			    var v = this.response[k];
			    delete this.response[k];
			    if (k.indexOf('DEFAULT`') == 0) {
				k = k.slice(8);
			    }
			    poststates[k] = v;
			}
		    }
		    this.response.prestates = prestates;
		    this.response.poststates = poststates;
		    if (this.onreadystatechange) {
			this.onreadystatechange();
		    }
		    if (this.onsuccess || this.onerror) {
			var msg = this.response.message;
			if (this.onsuccess && msg == "") {
			    this.onsuccess();
			}
			if (this.onerror && msg != "") {
			    this.onerror();
			}
		    }
		}
	    }
	}
	var json = {"source": source, "expression": expression};
	for (let k in prestates) {
	    var v = prestates[k];
	    if (k.indexOf('`') < 0) {
		k = "DEFAULT`" + k;
	    }
	    json[k] = v;
	}
	this.req.send(JSON.stringify(json));
	if (!this.async) {
	    this.status = this.req.status;
	    this.responseText = this.req.responseText;
	    if (this.status == 200) {
		this.response = JSON.parse(this.req.responseText);
		var poststates = {};
		for (let k in this.response) {
		    if (k.indexOf('`') > 0) {
			var v = this.response[k];
			delete this.response[k];
			if (k.indexOf('DEFAULT`') == 0) {
			    k = k.slice(8);
			}
			poststates[k] = v;
		    }
		}
		this.response.prestates = prestates;
		this.response.poststates = poststates;
	    }
	}
    };
