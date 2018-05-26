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

public extension HTTPHeaderName {
    /// X-XSS-Protection header.
    public static let xXSSProtection = HTTPHeaderName("X-XSS-Protection")
}

///  X-XSS-Protection Headers
///
///  This header enables the Cross-site scripting (XSS) filter in your browser.
public final class XSSProtectionMiddleware: Middleware {

    public enum HeaderOption {
        /// Filter disabled
        case disable
        /// Filter enabled. If a cross-site scripting attack is detected, in order to stop the attack, the browser will sanitize the page
        case sanitizePage
        /// Filter enabled. Rather than sanitize the page, when a XSS attack is detected, the browser will prevent rendering of the page
        case preventRendering
        /// Filter enabled. The browser will sanitize the page and report the violation. This is a Chromium function utilizing CSP violation reports to send details to a URI of your choice
        ///
        /// - Parameters:
        ///   - url: http://[YOURDOMAIN]/your_report_URI
        case sanitizeReport(url: String)


        public var rawValue: String {
            switch self {
            case .disable:
                return "0"

            case .sanitizePage:
                return "1"

            case .preventRendering:
                return "1; mode=block"

            case .sanitizeReport(let url):
                return "1; report=\(url)"

            }
        }
    }

    /// Option used for the X-XSS-Protection Header
    public let option: HeaderOption

    public init(option: HeaderOption) {
        self.option = option
    }

    public func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {

        return try next.respond(to: request).map { res in
            res.http.headers.replaceOrAdd(name: .xXSSProtection, value: self.option.rawValue)
            return res
        }
    }
}
