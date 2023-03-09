##locals
locals {
    priv_ins = flatten(local.private)
    pub_ins = flatten(local.public)

    public = [
    for pub in var.public_mod : [
      for i in range(1, pub.no_of_instances+1) : {
        instance_name = "${pub.name}-${i}"
        instance_type = pub.inst_type
        key_name = pub.key_name
        subnet_id   = pub.subnet_id
        security_groups = pub.security_groups
        }
      ]
    ]
   private = [
    for ins in var.private_mod : [
     for i in range(1, ins.no_of_instances+1) : {
     instance_name = "${ins.name}-${i}"
     instance_type = ins.inst_type
     key_name = ins.key_name
     subnet_id   = ins.subnet_id
     security_groups = ins.security_groups
      }
    ]
  ]

}