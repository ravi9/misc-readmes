
# MLflow Basics
- MLflow: An open-source platform for managing the end-to-end machine learning lifecycle
- Tracking: Record and query experiments, including code, data, configurations, and results
- Projects: Package data science code in a reusable and reproducible format
- Models: Manage and deploy machine learning models
- Model Registry: Store, annotate, and manage models for collaboration and deployment

# MLflow Commands
```
mlflow ui                   # Launch the MLflow tracking UI
mlflow run                  # Run an MLflow project
mlflow experiments create   # Create a new experiment
mlflow experiments list     # List all experiments
mlflow experiments delete   # Delete an experiment
mlflow runs list            # List runs within an experiment
mlflow runs delete          # Delete runs from an experiment
mlflow models serve         # Serve a model as a REST API endpoint
mlflow models build-docker  # Build a Docker image for serving an MLflow model
mlflow models execute       # Execute a model in batch mode
mlflow models register      # Register a model with the Model Registry
mlflow models list          # List registered models in the Model Registry
```

# MLflow Tracking
```
import mlflow

mlflow.set_experiment("experiment_name")  # Set the experiment name

with mlflow.start_run():
    mlflow.log_param("param_name", param_value)  # Log a parameter
    mlflow.log_metric("metric_name", metric_value)  # Log a metric
    mlflow.log_artifact("path/to/artifact")  # Log an artifact (file or directory)
    mlflow.log_model(model, "model_name")  # Log a trained model
    mlflow.set_tag("tag_name", tag_value)  # Set a tag for the run
```

# MLflow Projects
- Define project dependencies and entry points in an `MLproject` file
- Use `mlflow run` to run the project locally or on a remote machine
- Package project code and dependencies for reproducibility

# MLflow Models
- Use `mlflow.sklearn`, `mlflow.tensorflow`, `mlflow.pytorch`, etc., to log models
- Serve models as REST API endpoints using `mlflow models serve`
- Build Docker images for model deployment using `mlflow models build-docker`
- Register models with the Model Registry for versioning and collaboration

# Best Practices
- Use meaningful names for experiments, runs, and models
- Log relevant parameters, metrics, and artifacts for each run
- Use tags to organize and filter runs based on important attributes
- Version your data and code to ensure reproducibility
- Use MLflow Projects to package and share reusable code
- Leverage the Model Registry to manage model versions and transitions
- Integrate MLflow with your existing tools and workflows (e.g., notebooks, CI/CD pipelines)

# Tips and Tricks
- Use the MLflow tracking UI to visualize and compare runs
- Use the `mlflow run` command to execute projects with different parameters
- Leverage MLflow's built-in integrations with popular ML libraries (e.g., scikit-learn, TensorFlow, PyTorch)
- Use MLflow's REST API to interact with the tracking server programmatically
- Set up a central MLflow tracking server for collaboration and persistent storage
- Use MLflow's database export functionality to analyze runs data with external tools
- Implement model versioning and staging in the Model Registry for controlled deployments
- Use MLflow's model signature and input example features to document model usage
