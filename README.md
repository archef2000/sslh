# sslh
<p>Docker alpine image containing <a href="https://github.com/yrutschle/sslh">sslh</a>, configurable with environment variables.</p>
<h2>Usage</h2>
<p>By default, no multiplexing options are enabled:</p>
<blockquote>
<p>Start and expose port 443 and/or 80 with no configurations</p>
</blockquote>
<pre><code class="language-bash">docker run -d -p 443:443 -p 80:80 --name sslh archef2000/sslh</code></pre>
<p>To configure a backend, set at least the <code>*_HOST</code> env var:</p>
<blockquote>
<p>Start and configure SSH, HTTP and HTTPS with default ports</p>
</blockquote>
<pre><code class="language-bash">docker run -e SSH_HOST=host -e HTTP_HOST=somehost.internal -e SOCKS5_HOST=socks5 -e HTTPS_HOST=somehost.internal -p 443:443 -p 80:80 archef2000/sslh</code></pre>
<p>If the service is not listening on the default port, it can be overridden with the <code>*_PORT</code> env var:</p>
<blockquote>
<p>Start and configure SSH,HTTP and HTTPS with custom ports</p>
</blockquote>
<pre><code class="language-bash">docker run -e SSH_HOST=host -e SSH_PORT=2222 -e HTTP_HOST=somehost.internal \
-e HTTP_HOST=8080 -e HTTPS_HOST=somehost.internal -e HTTPS_PORT=8443 -e OPENVPN_HOST=openvpn \
-e OPENVPN_PORT=1194 -e SOCKS5_PORT=1080 -e SOCKS5_HOST=socks5 -e ENABLE_IPV6=true -p 443:443 -p 80:80 archef2000/sslh</code></pre>
<h3>Available Environment Variables</h3>
<p>Naming should be self explanatory, defaults are indicated.</p>
<p>If a <code>*_HOST</code> environment variable is omitted, it will not be configured.</p>
<pre><code class="language-bash">HTTPS_HOST=
HTTPS_PORT=8443

OPENVPN_HOST=
OPENVPN_PORT=1194

SHADOWSOCKS_HOST=
SHADOWSOCKS_PORT=8388

SSH_HOST=
SSH_PORT=22

HTTP_HOST= 
HTTP_PORT=80

SOCKS5_HOST=socks5
 SOCKS5_PORT=1080
</code></pre>
<h2>docker-compose</h2>
<p>This can also be run with docker-compose:</p>
<pre><code class="language-yaml">---
version: '3'
services:
  sslh:
    image: archef2000/sslh:latest
    ports:
      - 443:443
      - 80:80
    environment:
      - HTTPS_HOST=web
      - HTTPS_PORT=443
      - HTTP_HOST=web
      - HTTP_PORT=80
      - SSH_HOST=172.17.0.1 # Point to the Docker Host's IP
      - SSH_PORT=22
      - OPENVPN_HOST=openvpn
      - OPENVPN_PORT=1194
      - SOCKS5_HOST=socks5
      - SOCKS5_PORT=1080
      - ENABLE_IPV6=true
</code></pre>
<hr>
