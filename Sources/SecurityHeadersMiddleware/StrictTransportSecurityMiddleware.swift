//  SecurityHeadersMiddleware
//
//  Created by Kevin Hoogheem on 5/26/18.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
import Vapor


/// Strict-Transport-Security
///
/// HTTP Strict Transport Security (HSTS) is a web security policy mechanism which helps to protect websites against protocol downgrade attacks and cookie hijacking. It allows web servers to declare that web browsers (or other complying user agents) should only interact with it using secure HTTPS connections, and never via the insecure HTTP protocol. HSTS is an IETF standards track protocol and is specified in RFC 6797. A server implements an HSTS policy by supplying a header (Strict-Transport-Security) over an HTTPS connection (HSTS headers over HTTP are ignored).
public final class StrictTransportSecurityMiddleware: Middleware {

    /// The time, in seconds, that the browser should remember that this site is only to be accessed using HTTPS
    public let seconds: Int

    /// If this optional parameter is specified, this rule applies to all of the site's subdomains as well
    public let includeSubDomains: Bool

    public init(seconds: Int = 31536000, includeSubDomains: Bool = true) {
        self.seconds = seconds
        self.includeSubDomains = includeSubDomains
    }

    public func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {

        return try next.respond(to: request).map { res in

            var options = "max-age=\(self.seconds)"

            if self.includeSubDomains == true {
                options += " ; includeSubDomains"
            }

            res.http.headers.replaceOrAdd(name: .strictTransportSecurity, value: options)
            return res
        }
    }

}
