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

///  X-Frame-Options Headers
///
///  X-Frame-Options response header improve the protection of web applications against Clickjacking. It declares a policy communicated from a host to the client browser on whether the browser must not display the transmitted content in frames of other web pages.
public final class XFrameOptionsMiddleware: Middleware {

    public enum HeaderOption {
        /// No rendering within a frame
        case deny
        /// No rendering if origin mismatch
        case sameorigin
        /// Allows rendering if framed by frame loaded from DOMAIN
        case allowFrom(domain: String)

        public var rawValue: String {
            switch self {
            case .deny:
                return "deny"
            case .sameorigin:
                return "sameorigin"
            case .allowFrom(let domain):
                return "allow-from: \(domain)"
            }
        }
    }

    /// Option used for the X-Frame Header
    public let option: HeaderOption

    public init(option: HeaderOption) {
        self.option = option
    }

    public func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {

        return try next.respond(to: request).map { res in
            res.http.headers.replaceOrAdd(name: .xFrameOptions, value: self.option.rawValue)
            return res
        }
    }
}
