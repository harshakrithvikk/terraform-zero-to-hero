#!/bin/bash

# Update package repositories
apt update

# Install Apache web server
apt install -y apache2

# Get the instance ID using the instance metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Install the AWS CLI
apt install -y awscli

# Download the images from S3 bucket (if required)
# aws s3 cp s3://myterraformprojectbucket2023/project.webp /var/www/html/project.png --acl public-read

# Create a simple HTML file with the portfolio content and display the images
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Portfolio</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap">
  <style>
    /* Fonts and general styling */
    body {
      font-family: 'Roboto', sans-serif;
      background-color: #f9f9f9;
      color: #333;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    
    .container {
      text-align: center;
    }
    
    /* Title animation */
    @keyframes colorChange {
      0% { color: #ff00ff; }
      50% { color: #00ff00; }
      100% { color: #0000ff; }
    }
    
    h1 {
      font-size: 3rem;
      animation: colorChange 2s infinite;
    }
    
    /* Subtitle animation */
    @keyframes slideIn {
      0% {
        opacity: 0;
        transform: translateY(-50px);
      }
      100% {
        opacity: 1;
        transform: translateY(0);
      }
    }
    
    h2 {
      font-size: 2rem;
      animation: slideIn 1s forwards;
    }

    p {
      font-size: 1.2rem;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>Terraform Project Server 1</h1>
    <h2>Instance ID: <span style="color:green">$INSTANCE_ID</span></h2>
    <p>Welcome to <span style="color: #ff00ff;">Terraform</span><span style="color: #00ff00;">Champs's</span> <span style="color: #0000ff;">Channel</span></p>
    <!-- You can add more content here if needed -->
  </div>
</body>
</html>
EOF

# Start Apache and enable it on boot
systemctl start apache2
systemctl enable apache2
