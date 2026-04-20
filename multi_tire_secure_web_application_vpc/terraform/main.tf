# Application Load Balancer
resource "aws_lb" "app" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.public[*].id
}

resource "aws_lb_target_group" "app" {
  name     = "${var.project_name}-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

# Launch Template & ASG
resource "aws_launch_template" "app" {
  name_prefix   = "${var.project_name}-lt"
  image_id      = "ami-0c7217cdde317cfec" # Amazon Linux 2023 (us-east-1)
  instance_type = "t2.micro"

  iam_instance_profile {
    name = aws_iam_instance_profile.app.name
  }

  vpc_security_group_ids = [aws_security_group.app.id]

  user_data = filebase64("${path.module}/userdata.sh")
}

resource "aws_autoscaling_group" "app" {
  name                = "${var.project_name}-asg"
  vpc_zone_identifier = aws_subnet.app[*].id
  target_group_arns   = [aws_lb_target_group.app.arn]
  desired_capacity    = 2
  max_size            = 4
  min_size            = 2

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
}

# RDS Multi-AZ Database
resource "aws_db_subnet_group" "data" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = aws_subnet.data[*].id
}

resource "aws_db_instance" "mysql" {
  identifier             = "${var.project_name}-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "cloudbite_db"
  username               = "admin"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.data.name
  vpc_security_group_ids = [aws_security_group.db.id]
  multi_az               = true
  publicly_accessible    = false
  skip_final_snapshot    = true # Set to false in real production
}
