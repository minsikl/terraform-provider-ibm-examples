data "ibm_resource_group" "group" {
  // Replace temp to your resource group name
  name = "temp"
}


resource "ibm_resource_instance" "ms-cos2" {
  name              = "ms-cos2"
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  resource_group_id = "${data.ibm_resource_group.group.id}"
  parameters = {
    "HMAC" = true
  }
}

resource "ibm_resource_key" "ms-cos2-key" {
  name                 = "ms-cos2-key"
  role                 = "Manager"
  resource_instance_id = "${ibm_resource_instance.ms-cos2.id}"

  //User can increase timeouts 
  timeouts {
    create = "15m"
    delete = "15m"
  }
  parameters = {
    "HMAC" = true
  }
}
