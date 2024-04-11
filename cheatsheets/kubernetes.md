```bash
# Cluster Management
kubectl version                           # Display the Kubernetes version
kubectl cluster-info                      # Display cluster information
kubectl get nodes                         # List all nodes in the cluster
kubectl describe node <node-name>         # Describe a specific node
kubectl top node <node-name>              # Display resource usage of a node

# Namespace Management
kubectl get namespaces                    # List all namespaces
kubectl create namespace <namespace>      # Create a new namespace
kubectl delete namespace <namespace>      # Delete a namespace

# Pod Management
kubectl get pods                          # List all pods in the current namespace
kubectl get pods -n <namespace>           # List all pods in a specific namespace
kubectl get pods -o wide                  # List all pods with additional details
kubectl describe pod <pod-name>           # Describe a specific pod
kubectl logs <pod-name>                   # Display logs of a pod
kubectl exec -it <pod-name> -- /bin/bash  # Run a command in a pod
kubectl delete pod <pod-name>             # Delete a pod

# Deployment Management
kubectl get deployments                   # List all deployments
kubectl create deployment <name> --image=<image>  # Create a new deployment
kubectl describe deployment <name>        # Describe a specific deployment
kubectl scale deployment <name> --replicas=<count>  # Scale a deployment
kubectl delete deployment <name>          # Delete a deployment

# Service Management
kubectl get services                      # List all services
kubectl expose deployment <name> --port=<port> --type=<type>  # Create a new service
kubectl describe service <name>           # Describe a specific service
kubectl delete service <name>             # Delete a service

# ConfigMap Management
kubectl get configmaps                    # List all ConfigMaps
kubectl create configmap <name> --from-file=<path>  # Create a ConfigMap from a file
kubectl describe configmap <name>         # Describe a specific ConfigMap
kubectl delete configmap <name>           # Delete a ConfigMap

# Secret Management
kubectl get secrets                       # List all Secrets
kubectl create secret generic <name> --from-literal=<key>=<value>  # Create a Secret
kubectl describe secret <name>            # Describe a specific Secret
kubectl delete secret <name>              # Delete a Secret

# Ingress Management
kubectl get ingress                       # List all Ingress resources
kubectl create ingress <name> --rule="<host>/<path>=<service>:<port>"  # Create an Ingress
kubectl describe ingress <name>           # Describe a specific Ingress
kubectl delete ingress <name>             # Delete an Ingress

# Horizontal Pod Autoscaler (HPA)
kubectl get hpa                           # List all HPA resources
kubectl autoscale deployment <name> --min=<min> --max=<max> --cpu-percent=<cpu>  # Create an HPA
kubectl describe hpa <name>               # Describe a specific HPA
kubectl delete hpa <name>                 # Delete an HPA

# Persistent Volume (PV) and Persistent Volume Claim (PVC)
kubectl get pv                            # List all PVs
kubectl get pvc                           # List all PVCs
kubectl create -f <pv-config.yaml>        # Create a PV from a YAML file
kubectl create -f <pvc-config.yaml>       # Create a PVC from a YAML file
kubectl delete pv <name>                  # Delete a PV
kubectl delete pvc <name>                 # Delete a PVC

# Kubectl Configuration
kubectl config view                       # View the current kubectl configuration
kubectl config use-context <context>      # Switch to a different context
kubectl config set-context <context> --namespace=<namespace>  # Set the default namespace for a context

# Troubleshooting
kubectl logs <pod-name>                   # Display logs of a pod
kubectl describe pod <pod-name>           # Describe a specific pod
kubectl exec -it <pod-name> -- /bin/bash  # Run a command in a pod
kubectl get events                        # List recent events in the cluster
kubectl top pod <pod-name>                # Display resource usage of a pod

# YAML Configuration
# Create resources from a YAML file
kubectl apply -f <config.yaml>            # Create or update resources defined in a YAML file
kubectl delete -f <config.yaml>           # Delete resources defined in a YAML file

# Debugging
kubectl run -i --tty --image=<image> <name> --restart=Never -- /bin/bash  # Run a pod for debugging
kubectl port-forward <pod-name> <local-port>:<pod-port>  # Forward a local port to a pod
```

## Summary
This cheatsheet covers various aspects of Kubernetes, including:
- Cluster management commands for viewing cluster information and managing nodes.
- Namespace management commands for creating, listing, and deleting namespaces.
- Pod management commands for creating, listing, describing, and deleting pods, as well as executing commands in pods and viewing logs.
- Deployment management commands for creating, scaling, and deleting deployments.
- Service management commands for creating, exposing, and deleting services.
- ConfigMap and Secret management commands for creating, describing, and deleting ConfigMaps and Secrets.
- Ingress management commands for creating and managing Ingress resources.
- Horizontal Pod Autoscaler (HPA) commands for creating and managing HPAs.
- Persistent Volume (PV) and Persistent Volume Claim (PVC) commands for managing storage resources.
- Kubectl configuration commands for viewing and modifying the kubectl configuration.
- Troubleshooting commands for debugging and analyzing issues in the cluster.
- YAML configuration commands for creating and managing resources using YAML files.
- Debugging commands for running pods for debugging purposes and forwarding local ports to pods.

Remember to replace placeholders like `<pod-name>`, `<deployment-name>`,
 `<namespace>`, etc., with actual values specific to your environment.

 ## Sample YAML


1. Deployment:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: my-deployment
   spec:
     replicas: 3
     selector:
       matchLabels:
         app: my-app
     template:
       metadata:
         labels:
           app: my-app
       spec:
         containers:
         - name: my-container
           image: my-image:latest
           ports:
           - containerPort: 80
   ```

2. Service:
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: my-service
   spec:
     selector:
       app: my-app
     ports:
     - port: 80
       targetPort: 80
     type: LoadBalancer
   ```

3. ConfigMap:
   ```yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: my-config
   data:
     config.properties: |
       key1=value1
       key2=value2
   ```

4. Secret:
   ```yaml
   apiVersion: v1
   kind: Secret
   metadata:
     name: my-secret
   type: Opaque
   data:
     username: base64-encoded-username
     password: base64-encoded-password
   ```

5. PersistentVolumeClaim:
   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: my-pvc
   spec:
     accessModes:
     - ReadWriteOnce
     resources:
       requests:
         storage: 5Gi
   ```

6. Ingress:
   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     name: my-ingress
   spec:
     rules:
     - host: example.com
       http:
         paths:
         - path: /
           pathType: Prefix
           backend:
             service:
               name: my-service
               port:
                 number: 80
   ```

7. Job:
   ```yaml
   apiVersion: batch/v1
   kind: Job
   metadata:
     name: my-job
   spec:
     template:
       spec:
         containers:
         - name: my-job-container
           image: my-job-image:latest
         restartPolicy: Never
     backoffLimit: 4
   ```

8. CronJob:
   ```yaml
   apiVersion: batch/v1beta1
   kind: CronJob
   metadata:
     name: my-cronjob
   spec:
     schedule: "*/5 * * * *"
     jobTemplate:
       spec:
         template:
           spec:
             containers:
             - name: my-cronjob-container
               image: my-cronjob-image:latest
             restartPolicy: OnFailure
   ```

9. HorizontalPodAutoscaler:
   ```yaml
   apiVersion: autoscaling/v2beta1
   kind: HorizontalPodAutoscaler
   metadata:
     name: my-hpa
   spec:
     scaleTargetRef:
       apiVersion: apps/v1
       kind: Deployment
       name: my-deployment
     minReplicas: 1
     maxReplicas: 5
     metrics:
     - type: Resource
       resource:
         name: cpu
         targetAverageUtilization: 50
   ```

10. RBAC (Role-Based Access Control):
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: Role
    metadata:
      name: my-role
    rules:
    - apiGroups: [""]
      resources: ["pods"]
      verbs: ["get", "list", "watch"]
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
      name: my-rolebinding
    subjects:
    - kind: User
      name: my-user
      apiGroup: rbac.authorization.k8s.io
    roleRef:
      kind: Role
      name: my-role
      apiGroup: rbac.authorization.k8s.io
    ```

Refer to the Kubernetes API reference documentation 
(https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.21/) 
for detailed information on the available fields and their usage for each 
resource type.

When creating Kubernetes YAML configuration files, pay attention to 
indentation, as YAML is sensitive to spaces. Use consistent indentation 
(usually 2 spaces) for clarity and readability.

It's also a good practice to organize your Kubernetes manifests into 
separate files based on their purpose and resource type. This makes it 
easier to manage and maintain your Kubernetes configurations.

Remember to validate your YAML files before applying them to your Kubernetes 
cluster using tools like `kubectl apply --dry-run` or `kubectl c
reate --dry-run --validate`.