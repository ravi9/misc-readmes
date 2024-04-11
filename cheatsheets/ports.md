
1. Port 80 (HTTP):
   - Port 80 is the default port for unencrypted HTTP (Hypertext Transfer Protocol) traffic.
   - It is used for serving web pages and web applications over the internet.
   - When you access a website using a URL without specifying the port 
     (e.g., `http://example.com`), the request is sent to port 80 by default.

2. Port 443 (HTTPS):
   - Port 443 is the default port for encrypted HTTPS (HTTP Secure) traffic.
   - It is used for securely serving web pages and web applications over the internet.
   - HTTPS uses SSL/TLS (Secure Sockets Layer/Transport Layer Security) to encrypt the communication between the client and the server.
   - When you access a website using a URL with `https://` (e.g., `https://example.com`), the request is sent to port 443 by default.

3. Port 22 (SSH):
   - Port 22 is the default port for SSH (Secure Shell) protocol.
   - It is used for securely accessing and managing remote servers or machines.
   - SSH provides an encrypted communication channel for remote command execution, file transfer, and tunneling.

4. Port 8080 (Alternative HTTP):
   - Port 8080 is commonly used as an alternative port for HTTP traffic.
   - It is often used by web servers or application servers when port 80 is already in use or restricted.
   - Many development frameworks and tools, such as Apache Tomcat and Django development server, use port 8080 by default.

5. Port 5000 (Flask default):
   - Port 5000 is the default port used by the Flask web framework in Python.
   - When running a Flask application using the built-in development server, it listens on port 5000 by default.
   - This port is commonly used during development and testing of Flask-based applications.

6. Port 8501 (TensorFlow Serving):
   - Port 8501 is the default port used by TensorFlow Serving for its REST API.
   - TensorFlow Serving is a system for serving machine learning models.
   - When deploying a TensorFlow model using TensorFlow Serving, you can access the model's predictions via the REST API on port 8501.

7. Port 8000 (Django default):
   - Port 8000 is the default port used by the Django web framework in Python.
   - When running a Django application using the built-in development server, it listens on port 8000 by default.
   - This port is commonly used during development and testing of Django-based applications.

8. Port 9090 (Prometheus):
   - Port 9090 is the default port used by Prometheus, a popular monitoring and alerting system.
   - Prometheus is often used in MLOps to collect and store metrics related to machine learning models and infrastructure.
   - The Prometheus server exposes its web interface and API on port 9090 by default.

9. Port 3306 (MySQL):
   - Port 3306 is the default port used by MySQL, a widely used relational database management system.
   - When connecting to a MySQL database server, clients typically use port 3306 to establish a connection.

10. Port 27017 (MongoDB):
    - Port 27017 is the default port used by MongoDB, a popular NoSQL database.
    - When connecting to a MongoDB database server, clients use port 27017 to communicate with the database.


When deploying machine learning models or services, it's crucial to ensure 
that the necessary ports are open and accessible for communication between 
different components. Firewall rules and security groups should be properly 
configured to allow traffic on the required ports while restricting access to 
unnecessary ports.