locals {
  subnet_ids = var.transit_gateway_attachment_subnet_name == "" ?
    # If no subnet name is specified, default to all private subnets
    module.vpc.outputs.private_subnet_ids :
    # Else, select the named subnet
    module.vpc.outputs.named_private_subnets_map[var.transit_gateway_attachment_subnet_name]
}

# Create a TGW attachment from this account's VPC to the TGW Hub
module "standard_vpc_attachment" {
  source  = "cloudposse/transit-gateway/aws"
  version = "0.12.0"

  existing_transit_gateway_id             = var.transit_gateway_id
  existing_transit_gateway_route_table_id = var.transit_gateway_route_table_id

  route_keys_enabled                                             = false
  create_transit_gateway                                         = false
  create_transit_gateway_route_table                             = false
  create_transit_gateway_vpc_attachment                          = true
  create_transit_gateway_route_table_association_and_propagation = false

  config = {
    "this" = {
      vpc_id                            = module.vpc.outputs.vpc_id
      subnet_ids                        = locals.subnet_ids
      route_to                          = []
      route_to_cidr_blocks              = []
      static_routes                     = []
      subnet_route_table_ids            = []
      transit_gateway_vpc_attachment_id = null
      vpc_cidr                          = null
    }
  }

  context = module.this.context
}
