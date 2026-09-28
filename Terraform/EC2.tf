# Creating EC2 instance 
resource "aws_instance" "ins" {
  ami           = var.ami
  instance_type = var.instance_type
  
  count = 5 # Increasing Instance Count
  key_name = aws_key_pair.key.key_name

# Attaching root size as 20GB
  root_block_device {
    delete_on_termination = true
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "-"
  }
}

# Generating Keypair 
resource "aws_key_pair" "key" {
  key_name   = "project-key"
  public_key = file("project-key.pub")
}