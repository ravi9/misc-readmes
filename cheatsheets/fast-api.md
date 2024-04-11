```python
# Installing FastAPI and Uvicorn
pip install fastapi uvicorn

# Importing necessary modules
from fastapi import FastAPI, Path, Query, Body, Header, Cookie, UploadFile, File, Form, HTTPException, Depends, Security
from pydantic import BaseModel
from typing import Optional, List

# Creating a FastAPI application
app = FastAPI()

# Defining a Pydantic model
class User(BaseModel):
    id: int
    name: str
    email: str
    age: Optional[int] = None

# Defining routes and handlers
@app.get("/")
def root():
    # Return a simple message for the root endpoint
    return {"message": "Hello, World!"}

@app.get("/items/{item_id}")
def get_item(item_id: int):
    # Retrieve an item by its ID
    return {"item_id": item_id}

@app.post("/users/")
def create_user(user: User):
    # Create a new user based on the provided data
    return user

@app.put("/users/{user_id}")
def update_user(user_id: int, user: User):
    # Update a user by their ID
    return {"user_id": user_id, "user": user}

@app.delete("/users/{user_id}")
def delete_user(user_id: int):
    # Delete a user by their ID
    return {"message": f"User {user_id} deleted"}

# Path parameters
@app.get("/items/{item_id}")
def get_item(item_id: int = Path(..., title="Item ID", ge=1)):
    # Retrieve an item by its ID with path parameter validation
    return {"item_id": item_id}

# Query parameters
@app.get("/users/")
def get_users(skip: int = 0, limit: int = 10):
    # Retrieve users with pagination using query parameters
    return {"skip": skip, "limit": limit}

# Request body
@app.post("/users/")
def create_user(user: User = Body(...)):
    # Create a new user based on the provided data in the request body
    return user

# Form data
@app.post("/login/")
def login(username: str = Form(...), password: str = Form(...)):
    # Handle a login form submission
    return {"username": username}

# File upload
@app.post("/upload/")
def upload_file(file: UploadFile = File(...)):
    # Handle a file upload
    return {"filename": file.filename, "content_type": file.content_type}

# Dependency injection
def get_db():
    # Simulated database connection
    db = "Database connection"
    return db

@app.get("/items/")
def get_items(db: str = Depends(get_db)):
    # Retrieve items from the database using dependency injection
    return {"items": ["Item 1", "Item 2"], "db": db}

# Error handling
@app.get("/items/{item_id}")
def get_item(item_id: int):
    if item_id == 0:
        raise HTTPException(status_code=400, detail="Item ID cannot be zero")
    return {"item_id": item_id}

# Running the FastAPI application with Uvicorn
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

## Summary
This cheatsheet covers various aspects of FastAPI, including:
- Installing FastAPI and Uvicorn
- Importing necessary modules
- Creating a FastAPI application
- Defining Pydantic models for data validation
- Defining routes and handlers for different HTTP methods (GET, POST, PUT, DELETE)
- Handling path parameters, query parameters, request bodies, form data, and file uploads
- Using dependency injection to provide dependencies to route handlers
- Handling errors and raising HTTP exceptions
- Running the FastAPI application with Uvicorn

Here's a brief explanation of some key concepts:
- `@app.get()`, `@app.post()`, `@app.put()`, `@app.delete()` are used to 
   define routes and map them to handlers for different HTTP methods.
- `Path`, `Query`, `Body`, `Form`, `File` are used to declare and 
   validate parameters for path parameters, query parameters, request bodies, form data, and file uploads, respectively.
- `Pydantic` models are used for data validation and serialization.
- `Depends` is used for dependency injection, allowing you to provide 
   dependencies to route handlers.
- `HTTPException` is used to raise HTTP exceptions and return appropriate 
   error responses.
- `uvicorn.run()` is used to run the FastAPI application with Uvicorn as the 
   ASGI server.
