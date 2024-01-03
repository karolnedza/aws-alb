# #####

# resource "aws_wafv2_web_acl" "example" {
#   name        = "managed-rule-example"
#   description = "Example of a managed rule."
#   scope       = "REGIONAL"

#   default_action {
#     allow {}
#   }

#   rule {
#     name     = "rule-1"
#     priority = 1

#     override_action {
#       count {}
#     }

#     statement {
#       managed_rule_group_statement {
#         name        = "AWSManagedRulesCommonRuleSet"
#         vendor_name = "AWS"

#         rule_action_override {
#           action_to_use {
#             count {}
#           }

#           name = "SizeRestrictions_QUERYSTRING"
#         }

#         rule_action_override {
#           action_to_use {
#             count {}
#           }

#           name = "NoUserAgent_HEADER"
#         }

#         scope_down_statement {
#           geo_match_statement {
#             country_codes = ["US", "NL"]
#           }
#         }
#       }
#     }

#    # token_domains = ["mywebsite.com", "myotherwebsite.com"]

#     visibility_config {
#       cloudwatch_metrics_enabled = false
#       metric_name                = "friendly-rule-metric-name"
#       sampled_requests_enabled   = false
#     }
#   }

#   tags = {
#     Tag1 = "Value1"
#     Tag2 = "Value2"
#   }

#   visibility_config {
#     cloudwatch_metrics_enabled = false
#     metric_name                = "friendly-metric-name"
#     sampled_requests_enabled   = false
#   }
# }


####


resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  #security_groups    = [aws_security_group.lb_sg.id]
  subnets            = ["subnet-0bc22ae0320a85dfd", "subnet-047c5e018075c4d52"]

  #enable_deletion_protection = true

  access_logs {
    bucket  = "avtrxbackup"
    prefix  = "test-lb"
    enabled = false
  }

  tags = {
    Environment = "production"
  }
}

#### 

#####

# resource "aws_wafv2_web_acl" "example2" {
#   name        = "another-rule-example2"
#   description = "Example of a managed rule."
#   scope       = "REGIONAL"

#   default_action {
#     allow {}
#   }

#   rule {
#     name     = "rule-2"
#     priority = 1

#     override_action {
#       count {}
#     }

#     statement {
#       managed_rule_group_statement {
#         name        = "AWSManagedRulesCommonRuleSet"
#         vendor_name = "AWS"

#         rule_action_override {
#           action_to_use {
#             count {}
#           }

#           name = "SizeRestrictions_QUERYSTRING"
#         }

#         rule_action_override {
#           action_to_use {
#             count {}
#           }

#           name = "NoUserAgent_HEADER"
#         }

#         scope_down_statement {
#           geo_match_statement {
#             country_codes = ["US", "NL"]
#           }
#         }
#       }
#     }

#    # token_domains = ["mywebsite.com", "myotherwebsite.com"]

#     visibility_config {
#       cloudwatch_metrics_enabled = false
#       metric_name                = "friendly-rule-metric-name2"
#       sampled_requests_enabled   = false
#     }
#   }

#   tags = {
#     Tag1 = "Value1"
#     Tag2 = "Value2"
#   }

#   visibility_config {
#     cloudwatch_metrics_enabled = false
#     metric_name                = "friendly-metric-name2"
#     sampled_requests_enabled   = false
#   }
# }


####


resource "aws_lb" "test2" {
  name               = "another-alb"
  internal           = false
  load_balancer_type = "application"
  #security_groups    = [aws_security_group.lb_sg.id]
  subnets            = ["subnet-0bc22ae0320a85dfd", "subnet-047c5e018075c4d52"]

  #enable_deletion_protection = true

  access_logs {
    bucket  = "avtrxbackup"
    prefix  = "test-lb"
    enabled = false
  }

  tags = {
    Environment = "production"
  }
}

####
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-013aaf4c10553bda6"

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["10.1.44.0/24"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}



#####

# resource "aws_wafv2_web_acl_association" "example" {
#    resource_arn = aws_lb.test.arn
#    web_acl_arn  = aws_wafv2_web_acl.example.arn
# }



# resource "aws_wafv2_web_acl_association" "example2" {
#    resource_arn = aws_lb.test2.arn
#    web_acl_arn  = aws_wafv2_web_acl.example2.arn
# }

#### 

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  provider = aws.us-east-1
}
