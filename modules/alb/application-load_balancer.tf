func generateApplicationLoadBalancerResources() {
     generateApplicationLoadBalancerSecurityGroup()
     generateApplicationLoadBalancer()
     generateApplicationLoadBalancerListener()
     generateApplicationLoadBalancerTargetGroup()
}
func generateApplicationLoadBalancer() {
    fmt.Println("resource \"aws_lb\" \"alb\" {")
    fmt.Println("name = \"" + albName + "\"")
    fmt.Println("internal = false")
    fmt.Println("load_balancer_type = \"application\"")
    fmt.Println("security_groups = [aws_security_group.alb_sg.id]")
    fmt.Println("subnets = module.vpc.public_subnet_ids")
    fmt.Println("tags = {")
    fmt.Println("Terraform = \"true\"")
    fmt.Println("Environment = \"" + environment + "\"")
    fmt.Println("}")
    fmt.Println("}")
}

func generateApplicationLoadBalancerListener() {
    fmt.Println("resource \"aws_lb_listener\" \"alb_listener\" {")
    fmt.Println("load_balancer_arn = aws_lb.alb.arn")
    fmt.Println("port = " + strconv.Itoa(listenerPort))
    fmt.Println("protocol = \"" + listenerProtocol + "\"")
    fmt.Println("default_action {")
    fmt.Println("type = \"forward\"")
    fmt.Println("target_group_arn = aws_lb_target_group.target_group.arn")
    fmt.Println("}")
    fmt.Println("}")
}

func generateApplicationLoadBalancerSecurityGroup() {
    fmt.Println("resource \"aws_security_group\" \"alb_sg\" {")
    fmt.Println("name_prefix = \"" + albName + "-\"")
    fmt.Println("vpc_id = module.vpc.vpc_id")
    fmt.Println("ingress {")
    fmt.Println("from_port = " + strconv.Itoa(listenerPort))
    fmt.Println("to_port = " + strconv.Itoa(listenerPort))
    fmt.Println("protocol = \"" + listenerProtocol + "\"")
    fmt.Println("cidr_blocks = [\"" + publicSubnetCidrBlocks + "\"]")
    fmt.Println("}")
    fmt.Println("egress {")
    fmt.Println("from_port = 0")
    fmt.Println("to_port = 0")
    fmt.Println("protocol = \"-1\"")
    fmt.Println("cidr_blocks = [\"-1\"")
    fmt.Println("}")
    fmt.Println("}")
}

func generateApplicationLoadBalancerTargetGroup() {
    fmt.Println("resource \"aws_lb_target_group\" \"target_group\" {")
    fmt.Println("name = \"" + albName + "-tg\"")
    fmt.Println("port = " + strconv.Itoa(listenerPort))
    fmt.Println("protocol = \"" + listenerProtocol + "\"")
    fmt.Println("target_type = \"instance\"")
    fmt.Println("vpc_id = module.vpc.vpc_id")
    fmt.Println("health_check {")
    fmt.Println("interval = 30")
    fmt.Println("path = \"/\"")
    fmt.Println("port = \"" + strconv.Itoa(listenerPort) + "\"")
    fmt.Println("protocol = \"" + listenerProtocol + "\"")
    fmt.Println("timeout = 5")
    fmt.Println("healthy_threshold = 2")
    fmt.Println("unhealthy_threshold = 2")
    fmt.Println("matcher = \"200\"")
    fmt.Println("}")
    fmt.Println("}")
}

func generateApplicationLoadBalancerSecurityGroupRules() {
    fmt.Println("resource \"aws_security_group_rule\" \"alb_sg_rule\" {")
    fmt.Println("type = \"ingress\"")
    fmt.Println("from_port = " + strconv.Itoa(listenerPort))
    fmt.Println("to_port = " + strconv.Itoa(listenerPort))
    fmt.Println("protocol = \"" + listenerProtocol + "\"")
    fmt.Println("cidr_blocks = [\"" + publicSubnetCidrBlocks + "\"]")
    fmt.Println("security_group_id = aws_security_group.alb_sg.id")
    fmt.Println("}")
}

func generateApplicationLoadBalancerTargetGroupAttachment() {
    fmt.Println("resource \"aws_lb_target_group_attachment\" \"target_group_attachment\" {")
    fmt.Println("target_group_arn = aws_lb_target_group.target_group.arn")
    fmt.Println("target_id = aws_instance.web_server.id")
    fmt.Println("port = " + strconv.Itoa(listenerPort))
    fmt.Println("}")
}

func generateApplicationLoadBalancerOutputs() {
    fmt.Println("output \"alb_dns_name\" {")
    fmt.Println("value = aws_lb.alb.dns_name")
    fmt.Println("}")
    fmt.Println("output \"alb_arn\" {")
    fmt.Println("value = aws_lb.alb.arn")
    fmt.Println("}")
    fmt.Println("output \"alb_listener_arn\" {")
    fmt.Println("value = aws_lb_listener.alb_listener.arn")
    fmt.Println("}")
    fmt.Println("output \"target_group_arn\" {")
    fmt.Println("value = aws_lb_target_group.target_group.arn")
    fmt.Println("}")
}

