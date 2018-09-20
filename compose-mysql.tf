data "ibm_space" "spacedata" {
  space = "your_space"
  org   = "your_org"
}

resource "ibm_service_instance" "ms-mysql1" {
  name       = "ms-mysql1"
  space_guid = "${data.ibm_space.spacedata.id}"
  service    = "compose-for-mysql"
  plan       = "Standard"
  parameters = {"db_version"="5.7.22"}
}

resource "ibm_service_key" "ms-mysql1-key" {
  name = "ms-mysql1-key"  
  service_instance_guid    = "${ibm_service_instance.ms-mysql1.id}"
}
