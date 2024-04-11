
# HTTP Methods
GET     - Retrieve a resource or collection of resources
POST    - Create a new resource
PUT     - Update an existing resource
PATCH   - Partially update an existing resource
DELETE  - Delete a resource

# HTTP Status Codes
200 OK                  - Request succeeded
201 Created             - Resource created successfully
204 No Content          - Request succeeded, no content returned
400 Bad Request         - Invalid request format
401 Unauthorized        - Authentication required
403 Forbidden           - Access denied
404 Not Found           - Resource not found
500 Internal Server Error - Server error occurred

# URL Structure
https://api.example.com/v1/users               - Base URL with API version and resource
https://api.example.com/v1/users/{id}          - Resource with ID parameter
https://api.example.com/v1/users?page=1&limit=10 - Query parameters for pagination

# Request Headers
Accept: application/json           - Specify the expected response format
Content-Type: application/json     - Specify the request payload format
Authorization: Bearer {token}      - Include authentication token

# Response Formats
JSON (JavaScript Object Notation)  - Lightweight and widely supported
XML (eXtensible Markup Language)   - More verbose, useful for complex data structures

# API Documentation
Swagger (OpenAPI)                  - Popular tool for documenting APIs
API Blueprint                      - Markdown-based documentation format
RAML (RESTful API Modeling Language) - YAML-based documentation format

# Authentication and Authorization
JWT (JSON Web Tokens)              - Stateless authentication using signed tokens
OAuth 2.0                          - Authorization framework for secure access delegation
API Keys                           - Simple authentication using unique keys

# API Versioning
/v1/, /v2/, ...                    - Include version in the URL path
Accept: application/vnd.api+json;version=1 - Specify version in the Accept header
?version=1                         - Include version as a query parameter

# Pagination
```
?page=1&limit=10                   - Page-based pagination
?offset=0&limit=10                 - Offset-based pagination
Link: <https://api.example.com/v1/users?page=2>; rel="next" - Include pagination links in headers
```
# Filtering and Sorting
```
?filter[name]=John                 - Filter by field value
?sort=name,-age                    - Sort by fields (ascending/descending)
```

# Error Handling
{ "error": "Invalid request", "details": [...] } - Return descriptive error messages
Use appropriate HTTP status codes   - Indicate the type of error

# Caching
Cache-Control: max-age=3600        - Set cache expiration time
ETag: "abc123"                     - Include entity tag for conditional requests
Last-Modified: Fri, 01 Jan 2022 00:00:00 GMT - Include last modification timestamp

# Rate Limiting
X-RateLimit-Limit: 100             - Include rate limit information in headers
X-RateLimit-Remaining: 99
X-RateLimit-Reset: 1622400000

# Security
Use HTTPS                          - Encrypt communication between client and server
Validate and sanitize user input   - Prevent SQL injection and cross-site scripting (XSS) attacks
Use secure authentication mechanisms - Protect against unauthorized access
Implement rate limiting            - Prevent abuse and protect server resources

# Best Practices
```
Use meaningful and consistent naming conventions - Improve API readability 
and maintainability
Follow the principle of least privilege - Grant only necessary permissions
Use appropriate HTTP methods and status codes - Adhere to REST principles
Provide comprehensive API documentation - Facilitate API adoption and usage
Version your API                   - Handle changes and backward compatibility
Implement proper error handling    - Provide informative error messages
Use pagination, filtering, and sorting - Efficiently handle large datasets
Implement caching                  - Improve performance and reduce server 
load
Use rate limiting                  - Protect against excessive or abusive 
requests
Secure your API                    - Implement authentication, authorization, 
and encryption
Test your API thoroughly           - Ensure reliability and catch bugs early
Monitor and log API usage          - Gain insights and troubleshoot issues
```

This cheatsheet covers various aspects of REST API development, including:
- HTTP methods and their usage
- HTTP status codes and their meanings
- URL structure and query parameters
- Request headers and response formats
- API documentation tools and formats
- Authentication and authorization mechanisms
- API versioning strategies
- Pagination, filtering, and sorting techniques
- Error handling best practices
- Caching and rate limiting headers
- Security considerations and best practices
- General best practices for API design and development


# API Design Principles
- Use nouns, not verbs, in endpoint paths (/users instead of /getUsers)
- Use plural nouns for collections (/users instead of /user)
- Use nested paths for relationships (/users/{id}/orders)
- Use query parameters for filtering, sorting, and pagination
  (/users?sort=name&page=1)
- Use appropriate HTTP methods (GET, POST, PUT, PATCH, DELETE) for 
  CRUD operations
- Use appropriate HTTP status codes to indicate the result of an operation
- Use meaningful and consistent naming conventions for endpoints, parameters, 
  and responses
- Use versioning to handle changes and maintain backward compatibility

# API Documentation
- Provide clear and concise documentation for each endpoint
- Include request and response examples
- Specify required and optional parameters
- Describe authentication and authorization requirements
- Explain error codes and their meanings
- Keep documentation up to date with API changes

# Error Handling
- Return appropriate HTTP status codes for errors (400, 401, 403, 404, 500, etc.)
- Provide meaningful error messages and details in the response body
- Use consistent error response format across the API
- Log errors on the server-side for debugging and monitoring purposes

# Security
- Always use HTTPS to encrypt data in transit
- Implement secure authentication and authorization mechanisms (e.g., OAuth 2.0, JWT)
- Validate and sanitize user input to prevent injection attacks (e.g., SQL injection, XSS)
- Use rate limiting to protect against excessive or abusive requests
- Keep sensitive information (e.g., API keys, tokens) secure and avoid 
  exposing them in URLs or logs

# Performance
- Optimize database queries to minimize response times
- Use caching to reduce the load on the server and improve response times
- Implement pagination to limit the amount of data returned in a single request
- Compress responses using gzip or other compression techniques
- Use asynchronous processing for resource-intensive tasks

# Scalability
- Design your API to be stateless, allowing for horizontal scaling
- Use load balancing to distribute requests across multiple servers
- Implement caching and CDN to handle high traffic loads
- Monitor and track API usage to identify bottlenecks and optimize performance

# API Versioning
- Use a consistent versioning scheme (e.g., v1, v2) in the URL or header
- Maintain backward compatibility when introducing new versions
- Clearly communicate deprecation plans and provide migration guides for clients
- Consider using API gateways or management tools to handle versioning and 
  routing

# Dos
- Follow REST principles and conventions
- Use meaningful and consistent naming conventions
- Provide comprehensive and up-to-date documentation
- Handle errors gracefully and return meaningful error messages
- Secure your API using industry best practices
- Optimize performance and scalability
- Version your API and handle changes gracefully
- Test your API thoroughly, including edge cases and error scenarios

# Don'ts
- Don't expose sensitive information in URLs, headers, or error messages
- Don't use verbs in endpoint paths (/getUsers instead of /users)
- Don't return unnecessary data in responses
- Don't use HTTP methods incorrectly (e.g., using GET for creating resources)
- Don't ignore security best practices
- Don't make breaking changes without versioning
- Don't forget to update documentation when making changes to the API
