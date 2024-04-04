# ldap-instance module
Spawn an LDAP instance inside a specific subnet exposed via a Private Link service. 
Master password of this LDAP instance will be sent to AWS SSM Parameter.
`ldap-instance` module will also create a jump host for admin access into this LDAP instance.
