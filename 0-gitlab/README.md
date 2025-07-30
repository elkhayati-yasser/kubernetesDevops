# 🚀 GitLab Platform Setup with Docker

This folder sets up a self-hosted GitLab instance with:

- ✅ GitLab CE in Docker  
- 🔒 HTTPS using self-signed certificates  
- 🐳 Docker-in-Docker (DinD) for isolated CI/CD  
- 🔧 GitLab Runner (Docker executor)  
- 🔐 Sysbox runtime for secure builds  
- 📦 Private container registry  

---

## 📜 1. TLS Certificates

1. Go to the `ssl/` directory.
2. Generate the certificate and key:


   ```bash
   openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
     -keyout gitlab.yasserelkhayati.com.key \
     -out gitlab.yasserelkhayati.com.crt \
     -config openssl.cnf
   ```
  ```
  openssl req -new -x509 -days 365 -text \
  -key gitlab.yasserelkhayati.com.key \
  -out gitlab.yasserelkhayati.com.cert
  ```

![Screenshot of files in ssl folder](/0-gitlab/1.PNG)

## 📜 2. GitLab Server and Runner

In the project root (where docker-compose.yml is), run:

    ``` 
    docker compose up -d
    ```
Register your GitLab Runner:

    ```
    gitlab-runner register
    ```

Edit config.toml with your registration token and settings.


## 📜 3. Sysbox Runtime


Using Sysbox improves security by avoiding Docker socket and privileged mode.

    1- Install Sysbox

    2- Verify installation:
    
      ```
      sysbox-runc --version
      docker info | grep Runtimes
      ```

We should see sysbox listed.

In docker-compose.yml, set the runner container's runtime:   runtime: sysbox-runc Also update config.toml

By switching to Sysbox, we eliminate the security risks of Privileged Mode and Docker socket mounting, making GitLab CI/CD pipelines more secure and efficient.

## 📜 4. GitLab Container Registry

GitLab Container Registry offers a seamless, secure, and private alternative to public Docker registries like Docker Hub

Create a directory for Docker to trust the registry's SSL cert:

        ```
        mkdir -p /etc/docker/certs.d/gitlab.yasserelkhayati.com:5050
        ```

and place the certificates generated before inside the created folder And Ensure the runner container has this cert folder mounted in config.toml:


![Screenshot of files in docker folder to authenticate in the CR](/0-gitlab/2.PNG)

Authenticate to the container using a GitLab Personal Access Token (PAT) during CI/CD.

Final Step: Restart Services

After changes, restart everything:

          ```
          docker compose restart
          ```

GitLab UI will be available at:
https://gitlab.yasserelkhayati.com

Password instial access      

             ```
             docker exec -it <gitlab_container_name> cat /etc/gitlab/initial_root_password
             ```

## 📜 5. import petclinc into gitlab

Activate fisrt the priviledge 

![Activate fisrt the priviledge](/0-gitlab/3.PNG)

Generate an access token from GitHub and then import it into the current project.

![imported to the current project](/0-gitlab/4.PNG)


