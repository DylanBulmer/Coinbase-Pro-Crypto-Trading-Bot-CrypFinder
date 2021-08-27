# Kubernetes Example

This example works slightly differently to the docker one. Here we have two files; one for creating secrets and the other to create the deployment. Both files start with a three-digit number to help remind the order of which the files need to be applyed.

The `001-Secrets.yml` file must be applied first. It creates the environment variables to be used durring Deployment creation. **_UPDATE THE ENV VARIABLES IN THIS FILE._**

Next the `002-Deployment.yml` file can be applied. This one creates and serves the app ("bot") deployment.

To apply the files run `kubectl apply -f <file-name>.yml`.
