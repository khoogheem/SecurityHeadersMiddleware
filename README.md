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
