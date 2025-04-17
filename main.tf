resource "aws_instance" "ec2" {
  for_each = var.instances
  ami = each.value.ami
  instance_type = each.value.instance_type
  key_name = each.value.key_name
  subnet_id = each.value.subnet_id
  vpc_security_group_ids = concat([aws_security_group.sg.id], each.value.vpc_security_group_ids)
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  root_block_device {
    volume_size = each.value.root_block_device.volume_size
    volume_type = each.value.root_block_device.volume_type
  }
  dynamic "ebs_block_device" {
    for_each = each.value.ebs_block_device
    content {
      device_name = ebs_block_device.value.device_name
      volume_size = ebs_block_device.value.volume_size
      volume_type = ebs_block_device.value.volume_type
    }
  }

  user_data = templatefile("${path.module}/user_data/user_data.sh.tftpl", {hostname = each.key})

  lifecycle {
    ignore_changes = [ iam_instance_profile, security_groups, tags ]
  }

  tags = merge(local.default_tags, each.value.tags, {
    Name = each.key
  })
}