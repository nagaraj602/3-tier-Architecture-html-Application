resource "aws_autoscaling_group" "app_asg" {
  name                = "app-auto-scaling-group"
  vpc_zone_identifier = [aws_subnet.private_app_1.id, aws_subnet.private_app_2.id]
  target_group_arns   = [aws_lb_target_group.app_tg.arn]
  min_size            = 2
  max_size            = 4
  desired_capacity    = 2

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }
}