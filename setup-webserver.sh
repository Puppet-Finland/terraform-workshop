#!/bin/bash
apt-get update
apt-get install nginx -y
ufw allow 'Nginx HTTP'

cat << 'EOF' > /var/www/html/index.nginx-debian.html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Hello Terraform</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
      crossorigin="anonymous"
    />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js"></script>
  </head>

  <body style="background-color: #efefef">
    <div class="container mt-5">
      <center>
        <h1 style="font-family: sans-serif; font-size: 3rem">Welcome to Terraform!</h1>
      </center>
        <div class="card w-100 my-5">
          <div class="card-body">
            <h5 class="card-title">Terraform</h5>
            <h6 class="card-subtitle mb-2 text-muted">by HashiCorp</h6>
            <p class="card-text">
              Terraform is an open-source infrastructure as code software tool
              that provides a consistent CLI workflow to manage hundreds of
              cloud services. Terraform codifies cloud APIs into declarative
              configuration files.
            </p>
            <a href="https://www.terraform.io/docs/index.html" class="card-link">Docs</a>
            <a href="https://www.hashicorp.com/blog" class="card-link">Blog</a>
          </div>
        </div>
    </div>
  </body>
</html>
EOF