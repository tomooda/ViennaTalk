const opaque = document.body.style.opacity;
document.body.style.opacity = 0;

const loadAsset = (type, url) => new Promise((resolve, reject) => {
  if (type === 'script') {
    const script = document.createElement('script');
    script.src = url;
    script.async = false;
    script.onload = () => resolve();
    script.onerror = () => reject(new Error(`Failed to load: ${url}`));
    document.head.appendChild(script);
  } else if (type === 'link') {
    const link = document.createElement('link');
    link.rel = 'stylesheet';
    link.href = url;
    document.head.appendChild(link);
    resolve();
  }
});


await loadAsset('script', 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js');
await loadAsset('link', 'https://viennatalk.org/ViennaDoc/ViennaDoc.css');
await loadAsset('script', 'https://viennatalk.org/ViennaDoc/ViennaClient.js');

document.body.style.opacity = 1;

export const ViennaDoc = {};
ViennaDoc.value_prefix = '\u261E ';
ViennaDoc.source = "";
ViennaDoc.states = {};
String.prototype.vienna_globalName = function (module="DEFAULT") {
    if (this.indexOf("`") >= 0) {
	return this;
    }
    return module + "`" + this;
};

ViennaDoc.eval = function(expression, prestates = {}, module="DEFAULT") {
    for (let varname in prestates) {
	if (prestates[varname]) {
	    ViennaDoc.states[varname.vienna_globalName(module)] = prestates[varname];
	}
    }
    var result = ViennaDoc.source.vienna_eval(expression, ViennaDoc.states, module);
    ViennaDoc.states = result.poststates;
    ViennaDoc.watch.forEach(function(node) {
	var module = node.getAttribute("module") || "DEFAULT";
        var key = node.innerText;
	if (key.indexOf('`') < 0)
	    key = module+'`'+key;
	node.nextSibling.innerText = ViennaDoc.value_prefix + ViennaDoc.states[key];
    });
    return result;
};

ViennaDoc.evalShow = function(node, expression, prestates, poststates, module="DEFAULT") {
    var result = ViennaDoc.eval(expression, prestates, module);
    var text = ""
    if (prestates != {}) {
	text = text + " {" + Object.keys(prestates).map(
	    function (v) {
		return v + "=" + result.prestates[v.vienna_globalName(module)];
	    }).join(',') + "} " + expression + " \u261E ";
    }
    if (result.message == "") {
	text = text + result.value;
	if (poststates != {}) {
	    text = text + " {" + Object.keys(poststates).map(function (v) {
		return v + "=" + result.poststates[v.vienna_globalName(module)];
	    }).join(',') + "} ";
	}
    } else {
	text = text + "ERROR! ";
    }
    node.innerText = text;
};

ViennaDoc.valueShow = function(node, expression, module="DEFAULT") {
    var result = ViennaDoc.eval(expression, {}, module);
    var text = ""
    if (result.message == "") {
	text = " \u261E " + result.value;
    } else {
	text = " \u261E " + "ERROR! ";
    }
    node.innerText = text;
};

ViennaDoc.parseStates = function (str, module) {
    var states = {};
    if (str) {
	str.split(",").map(str=>str.trim()).forEach(function (bind) {
	    if (bind) {
		const pair = bind.split("=");
		const varname = pair[0].trim();
		if (pair.length > 1) {
		    states[varname] = pair[1].trim();
		} else {
		    states[varname] = null;
		}
	    }
	});
    }
    return states;
}

ViennaDoc.initializeViennaSourceNode = function(node) {
    var preNode = document.createElement("pre");
    node.parentNode.insertBefore(preNode, node.nextSibling);
    preNode.appendChild(node);
    var src = node.getAttribute("src");
    if (src != null) {
	src = ViennaDoc.sources[src] || "";
    } else {
	src = ViennaDoc.source || "";
    }
    node.innerHTML = hljs.highlightAuto(src).value;
    node.style.backgroundColor = "#eee";
    node.style.display = "block";
};

ViennaDoc.initializeViennaEvalNode = function(node) {
    var expr = node.innerText;
    var module = node.getAttribute("module") || "DEFAULT";
    var prestates = ViennaDoc.parseStates(node.getAttribute("prestates"), module);
    var poststates = ViennaDoc.parseStates(node.getAttribute("poststates"), module);
    var nextNode = node.nextSibling;
    var buttonNode = document.createElement("input");
    var valueNode = document.createElement("code");
    node.style.backgroundColor = "#eee";
    buttonNode.type = "button";
    buttonNode.value = "run";
    buttonNode.onclick = function(){ViennaDoc.evalShow(valueNode, expr, prestates, poststates, module);};
    valueNode.className = "vdm";
    valueNode.style.backgroundColor = "#eee";
    valueNode.style.cursor = "pointer";
    valueNode.onclick=function() {this.innerText="";};
    node.parentNode.insertBefore(buttonNode, nextNode);
    node.parentNode.insertBefore(valueNode, nextNode);
}

ViennaDoc.initializeViennaValueNode = function(node) {
    var expr = node.innerText;
    var module = node.getAttribute("module") || "DEFAULT";
    var nextNode = node.nextSibling;
    var buttonNode = document.createElement("input");
    var valueNode = document.createElement("code");
    node.style.backgroundColor = "#eee";
    buttonNode.type = "button";
    buttonNode.value = "run";
    buttonNode.onclick = function(){ViennaDoc.valueShow(valueNode, expr, module);};
    valueNode.className = "vdm";
    valueNode.style.backgroundColor = "#eee";
    valueNode.style.cursor = "pointer";
    valueNode.onclick=function() {this.innerText="";};
    node.parentNode.insertBefore(buttonNode, nextNode);
    node.parentNode.insertBefore(valueNode, nextNode);
}

ViennaDoc.initializeViennaWatchNode = function(node) {
    var expr = node.innerText;
    var valueNode = document.createElement("code");
    node.style.backgroundColor = "#eee";
    valueNode.className = "vdm";
    valueNode.style.backgroundColor = "#eee";
    node.parentNode.insertBefore(valueNode, node.nextSibling);
    ViennaDoc.watch.push(node);
};

ViennaDoc.initializeViennaAssertNode = function(node) {
    var savedStates = Object.assign({}, ViennaDoc.states);
    var expected = node.innerText;
    var module = node.getAttribute("module") || "DEFAULT";
    var prestates = ViennaDoc.parseStates(node.getAttribute("prestates"), module);
    var expression = node.getAttribute("eval");
    if (!expression) {
	var warningNode = document.createElement("span");
	warningNode.innerText = "[not validated]";
	warningNode.style.color = "#800000";
	node.parentNode.insertBefore(warningNode, node.nextSibling);
	return false;
    }
    var result = ViennaDoc.eval(expression, prestates, module);
    ViennaDoc.states = savedStates;
    var actual = result.value;
    if (result.message || actual != expected) {
	var warningNode = document.createElement("span");
	var text = "[invalid: ";
	if (prestates != {}) {
	    text = text + " {" + Object.keys(prestates).map(
		function (v) {
		    return v + "=" + result.prestates[v.vienna_globalName(module)];
		}).join(',') + "} " + expression + " \u261E ";
	}
	if (result.message == "") {
	    text = text + result.value;
	} else {
	    text = text + "ERROR! ";
	}
	text = text + "]";
	warningNode.innerText = text;
	warningNode.style.color = "#800000";
	node.parentNode.insertBefore(warningNode, node.nextSibling);
	return false;
    }
    return true;
}

ViennaDoc.watch = [];
document.addEventListener('DOMContentLoaded', (event) => {
    ViennaDoc.watch = [];
    document.querySelectorAll('code.vdm').forEach(function(node) {
	var vienna = node.getAttribute("vienna");
	if (vienna == "source")
	    ViennaDoc.initializeViennaSourceNode(node);
	if (vienna == "eval")
	    ViennaDoc.initializeViennaEvalNode(node);
	if (vienna == "value")
	    ViennaDoc.initializeViennaValueNode(node);
	if (vienna == "watch")
	    ViennaDoc.initializeViennaWatchNode(node);
	if (vienna == "assert")
	    ViennaDoc.initializeViennaAssertNode(node);
	if(node.parentNode.tagName.toLowerCase() != "pre") {
	    hljs.highlightElement(node);
	    node.style.display = "block-inline";
	    node.style.margin = "0 2px";
	    node.style.padding = "1px 3px";
	}
    });
    ViennaDoc.eval("nil");
});

hljs.registerLanguage('vdm', function(hljsApi) {
  var VDM_KEYWORDS = {
    keyword: 
      'state compose  inv init pre post types values functions operations traces ' +
      'to return definitions exports imports' +
      ' module end pure ' +
      'if then else elseif let in be st cases of lambda default ' +
      'forall exists exists1 mu iota dcl',
    literal: 
      'true false nil',
    type: 
      'nat nat1 int rat real char bool map set seq of token',
  };

  return {
    name: 'VDM',
    aliases: ['vdmsl'],
    keywords: VDM_KEYWORDS,
    contains: [
    {
        className: 'comment',
        begin: '--', end: '$'
      },
      {
        className: 'comment',
        begin: '/\\*', end: '\\*/'
      },
      {
        className: 'string',
        begin: '"', end: '"',
        illegal: '\\n'
      },
      {
        className: 'keyword',
        begin: '(pre_|is_|mk_|inv_|post_)'
      },
      {
        className: 'number',
        begin: '\\b\\d+(\\.\\d+)?\\b'
      },
      {
        className: 'symbol',
        begin: '(\\==>|\\==|\\->|\\|\\->|\\=>|\\:\\=|\\:\\:|\\||\\+|\\-|\\*|\\/|\\=|\\#|<|>|<=|>=)'
      },
      {
        className: 'variable',
        begin: '\\b[a-zA-Z_][a-zA-Z0-9_]*\\b',
        keywords: VDM_KEYWORDS
      }
    ]
  };
});
