/**
 * String.prototype.vienna_eval
 * 
 * @param {string} expr
 * @param {Object} [prestates={}]
 * @param {string} [module="DEFAULT"]
 * @returns {Promise<Object>}
 */
String.prototype.vienna_eval = async function(expr, prestates = {}, module = "DEFAULT") {
    const json = { source: this.toString(), expression: expr, module };
    
    for (const [k, v] of Object.entries(prestates)) {
        const key = k.includes('`') ? k : `DEFAULT\`${k}`;
        json[key] = v;
    }

    try {
        const response = await fetch("https://vdmpad.viennatalk.org/eval", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(json)
        });

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const result = await response.json();
        const poststates = {};

        for (const [k, v] of Object.entries(result)) {
            if (k.includes('`')) {
                delete result[k];
                const cleanKey = k.startsWith('DEFAULT`') ? k.slice(8) : k;
                poststates[cleanKey] = v;
            }
        }

        result.prestates = prestates;
        result.poststates = poststates;
        return result;
    } catch (error) {
        console.error("vienna_eval failed:", error);
        throw error;
    }
};

/**
 * ViennaClient
 */
class ViennaClient {
    /**
     * @param {string} [url="https://vdmpad.viennatalk.org/"]
     */
    constructor(url = "https://vdmpad.viennatalk.org/") {
        this.url = url;
        this.onreadystatechange = null;
        this.onsuccess = null;
        this.onerror = null;
        
        this.readyState = 0;
        this.status = 0;
        this.responseText = "";
        this.response = null;
    }

    /**
     * @param {string} expression
     * @param {string} [source=""]
     * @param {Object} [prestates={}]
     * @returns {Promise<Object>}
     */
    async eval(expression, source = "", prestates = {}) {
        this.readyState = 1;
        this.onreadystatechange?.();

        const json = { source, expression };
        for (const [k, v] of Object.entries(prestates)) {
            const key = k.includes('`') ? k : `DEFAULT\`${k}`;
            json[key] = v;
        }

        try {
            this.readyState = 3;
            this.onreadystatechange?.();

            const response = await fetch(`${this.url}eval`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(json)
            });

            this.status = response.status;
            this.responseText = await response.text();
            this.readyState = 4;

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            this.response = JSON.parse(this.responseText);

            const poststates = {};
            for (const [k, v] of Object.entries(this.response)) {
                if (k.includes('`')) {
                    delete this.response[k];
                    const cleanKey = k.startsWith('DEFAULT`') ? k.slice(8) : k;
                    poststates[cleanKey] = v;
                }
            }

            this.response.prestates = prestates;
            this.response.poststates = poststates;

            this.onreadystatechange?.();
            
            const msg = this.response.message;
            if (this.onsuccess && msg === "") {
                this.onsuccess();
            }
            if (this.onerror && msg !== "") {
                this.onerror();
            }

            return this.response;
        } catch (error) {
            this.readyState = 4;
            this.status = this.status || 500;
            this.onreadystatechange?.();
            this.onerror?.();
            throw error;
        }
    }
}
