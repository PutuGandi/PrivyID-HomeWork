resource "aws_route53_zone" "dev" {
  name = "gandi.my.id"

    tags = {
    Environment = "dev"
  }
}

resource "aws_route53_zone" "dev-private" {
  name = "gandi.my.id"

  vpc {
    vpc_id = aws_vpc.privyID.id
  }
}

#resource "aws_route53_record" "dev-ns" {
#  zone_id = aws_route53_zone.main.zone_id
#  name    = "dev.example.com"
#  type    = "NS"
#  ttl     = "30"
#  records = aws_route53_zone.dev.name_servers
#}

