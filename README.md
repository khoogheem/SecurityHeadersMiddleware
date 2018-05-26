[![Swift4](https://img.shields.io/badge/swift4-compatible-4BC51D.svg?style=flat)](https://developer.apple.com/swift)
[![Vapor3](https://img.shields.io/badge/Vapor-3.0-red.svg)](http://vapor.codes)



# SecurityHeadersMiddleware

Security Headers Middleware for Vapor3, provides middleware to add in security HTTP Headers.

Example use:

```
let strictTransport = StrictTransportSecurityMiddleware(seconds: 4500, includeSubDomains: false)

let xframe = XFrameOptionsMiddleware(option: .allowFrom(domain: "example.com"))

let xss = XSSProtectionMiddleware(option: .sanitizePage)

let authSessionRoutes = router.grouped(XContentTypeOptionsMiddleware(),
                                        strictTransport,
                                        xframe,
                                        xss
                                       )
```
