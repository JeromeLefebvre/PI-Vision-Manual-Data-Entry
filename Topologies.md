# PI Vision and manual data logger

## Everything on one machine
See my article on PI Square

## ERRORS

In general the layers that need to be crossed
1. Certificate
2. PI Vision Secruity Policy
3. PI Web API CORS
4. 
### CORS error
Full message: Access to XMLHttpRequest at 'https://.../piwebapibatch' from origin 'https://...' has been blocked by CORS policy: Response to preflight request doesn't pass access control check: No 'Access-Control-Allow-Origin' header is present on the requested resource.

Reference article:
https://osisoft.lightning.force.com/lightning/r/Knowledge__kav/ka01I0000007oHzQAI/view

## script-src errors
sym-sendvalue.js:269 Refused to load the script 'https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js' because it violates the following Content Security Policy directive: "script-src 'self' 'unsafe-eval' 'nonce-EdZj6Ic7hNXkpQpZ'". Note that 'script-src-elem' was not explicitly set, so 'script-src' is used as a fallback.

```

			// Load the script
			var script = document.createElement("SCRIPT");
			script.src = 'https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js';
			script.type = 'text/javascript';
			script.onload = function() {
				var $ = window.jQuery;
				// Use $ here...
			};
			document.getElementsByTagName("head")[0].appendChild(script);
```

## script-src errors
Adding in the template.html part of a custom symbol
```HTML
<script src="https://ajax.googleapis.com/ajax/libs/d3js/6.2.0/d3.min.js"></script>
```
Causes this error:
```
Refused to load the script 'https://ajax.googleapis.com/ajax/libs/d3js/6.2.0/d3.min.js' because it violates the following Content Security Policy directive: "script-src 'self' 'unsafe-eval' 'nonce-taTVTWOAfqMcBgf5'". Note that 'script-src-elem' was not explicitly set, so 'script-src' is used as a fallback.
```

Reloading the page shows a different nonce being used:
```
Refused to load the script 'https://ajax.googleapis.com/ajax/libs/d3js/6.2.0/d3.min.js' because it violates the following Content Security Policy directive: "script-src 'self' 'unsafe-eval' 'nonce-DSOTCwkw6BScd/Ff'". Note that 'script-src-elem' was not explicitly set, so 'script-src' is used as a fallback.
```

Modifying the web.config to have:
```HTML
<add key="ScriptSrcPolicy" value="ajax.googleapis.com" />
```
Now generates this error:
```
Refused to execute inline script because it violates the following Content Security Policy directive: "script-src 'self' 'unsafe-eval' 'nonce-iCbaNq2BB09OTIgz' ajax.googleapis.com". Either the 'unsafe-inline' keyword, a hash ('sha256-6wRdeNJzEHNIsDAMAdKbdVLWIqu8b6+Bs+xVNZqplQw='), or a nonce ('nonce-...') is required to enable inline execution.
```

Now modifiying the web.config to be as follows:
```HTML
 <add key="ScriptSrcPolicy" value="'sha256-6wRdeNJzEHNIsDAMAdKbdVLWIqu8b6+Bs+xVNZqplQw=' ajax.googleapis.com" />
```
Generated no more errors

Adding other libraries such as:
```HTML
<script src="https://ajax.googleapis.com/ajax/libs/dojo/1.13.0/dojo/dojo.js"></script>
```
Generated no futher errors


### Adding in further libraries from different CDN
Addinng in:
```HTML
<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/6.2.0/d3.min.js"></script>
```
Now generates:
```
jquery-3.5.0.js:10176 Refused to load the script 'https://cdnjs.cloudflare.com/ajax/libs/d3/6.2.0/d3.min.js' because it violates the following Content Security Policy directive: "script-src 'self' 'unsafe-eval' 'nonce-Zw2PvaRqzTe/0O6M' 'sha256-6wRdeNJzEHNIsDAMAdKbdVLWIqu8b6+Bs+xVNZqplQw=' ajax.googleapis.com". Note that 'script-src-elem' was not explicitly set, so 'script-src' is used as a fallback.
```

Modifying web.config to now be:
```HTML
<add key="ScriptSrcPolicy" value="'sha256-6wRdeNJzEHNIsDAMAdKbdVLWIqu8b6+Bs+xVNZqplQw=' ajax.googleapis.com cdnjs.cloudflare.com" />
```
Clears the error


<!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>-->



