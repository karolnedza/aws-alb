# #####

resource "aws_wafv2_web_acl" "example" {
  name        = "managed-rule-example"
  description = "Example of a managed rule."
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "rule-1"
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "SizeRestrictions_QUERYSTRING"
        }

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "NoUserAgent_HEADER"
        }

        scope_down_statement {
          geo_match_statement {
            country_codes = ["US", "NL"]
          }
        }
      }
    }

   # token_domains = ["mywebsite.com", "myotherwebsite.com"]

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "friendly-rule-metric-name"
      sampled_requests_enabled   = false
    }
  }

  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "friendly-metric-name"
    sampled_requests_enabled   = false
  }
}


#### 

#####

resource "aws_wafv2_web_acl" "example2" {
  name        = "another-rule-example2"
  description = "Example of a managed rule."
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "rule-2"
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "SizeRestrictions_QUERYSTRING"
        }

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "NoUserAgent_HEADER"
        }

        scope_down_statement {
          geo_match_statement {
            country_codes = ["US", "NL"]
          }
        }
      }
    }

   # token_domains = ["mywebsite.com", "myotherwebsite.com"]

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "friendly-rule-metric-name2"
      sampled_requests_enabled   = false
    }
  }

  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "friendly-metric-name2"
    sampled_requests_enabled   = false
  }
}


####
resource "aws_lb" "public" {
  name               = "public-alb"
  internal           = false
  load_balancer_type = "application"
  #security_groups    = [aws_security_group.lb_sg.id]
  subnets            = ["subnet-0bc22ae0320a85dfd", "subnet-047c5e018075c4d52"]

  access_logs {
    bucket  = "avtrxbackup"
    prefix  = "test-lb"
    enabled = false
  }

  tags = {
    Environment = "production",
    ApplicationAcronym =  "CDS"
  }
}


resource "aws_lb" "private" {
  name               = "private-alb"
  internal           = true  ###### Private
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
    Environment = "production",
    ApplicationAcronym =  "CDS"
  }
}

#####

# resource "aws_wafv2_web_acl_association" "example" {
#    resource_arn = aws_lb.public.arn
#    web_acl_arn  = aws_wafv2_web_acl.example.arn
# }



resource "aws_wafv2_web_acl_association" "example2" {
   resource_arn = aws_lb.private.arn
   web_acl_arn  = aws_wafv2_web_acl.example2.arn
}