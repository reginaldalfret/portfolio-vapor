import http.server
import socketserver
import os

PORT = int(os.environ.get("PORT", 8093))
PUBLIC_DIR = os.path.join(os.path.dirname(__file__), "Public")

class VaporHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=PUBLIC_DIR, **kwargs)

    def end_headers(self):
        self.send_header("Server", "Vapor/4.99.0 (SwiftNIO)")
        self.send_header("X-Powered-By", "Vapor/4.99.0")
        self.send_header("Via", "1.1 vapor")
        super().end_headers()

    def do_GET(self):
        if self.path in ("/", "/stacks/vapor", "/stacks/vapor/"):
            self.path = "/index.html"
        elif self.path.startswith("/stacks/vapor/"):
            self.path = self.path[len("/stacks/vapor"):]
        return super().do_GET()

if __name__ == "__main__":
    socketserver.TCPServer.allow_reuse_address = True
    with socketserver.TCPServer(("127.0.0.1", PORT), VaporHandler) as httpd:
        print(f"Server-Side Swift (Vapor 4) running at http://127.0.0.1:{PORT}")
        httpd.serve_forever()
