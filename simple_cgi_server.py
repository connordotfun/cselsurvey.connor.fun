#!/usr/bin/env python3
# coding: utf-8


from http.server import CGIHTTPRequestHandler
from http.server import HTTPServer

import cgitb; cgitb.enable() # enable CGI error reportin

PORT = 8000
server_address = ('', PORT)

handler = CGIHTTPRequestHandler
handler.cgi_directories = ['/cgi_bin/*']
server = HTTPServer(server_address, handler)

server.serve_forever()