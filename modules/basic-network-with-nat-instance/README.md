# basic-network module

Provide a basic VPC with:
- 1 private & 1 public subnet in same AZ.
- IGW
- Some pre-defined NACL template.
- Some pre-defined SG for common use case.

We don't create route table along with VPC since content of that table heavily depends on other component outside of this module
For example, you may want to point to a custom NAT Instance, a peering gateway,...
