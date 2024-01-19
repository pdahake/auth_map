# resource "kubernetes_config_map" "aws-auth" {
#   data = {
#     "mapRoles" = <<EOT
# - groups:
#   - system:bootstrappers
#   - system:nodes
#   rolearn: arn:aws:iam::635066407893:role/spot-eks-node-group-20240118192431408500000003
#   username: system:node:{{EC2PrivateDNSName}}
# - groups:
#   - system:bootstrappers
#   - system:nodes
#   rolearn: arn:aws:iam::635066407893:role/general-eks-node-group-20240118192431454900000005
#   username: system:node:{{EC2PrivateDNSName}}
# EOT
#   }

#   metadata {
#     name      = "aws-auth"
#     namespace = "kube-system"
#   }
# }