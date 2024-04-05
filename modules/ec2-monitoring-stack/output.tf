output "cpu_alert_name" {
  value       = local.name_alert_cpu
  description = "Name of the CPU alert."
}

output "mem_alert_name" {
  value       = local.name_alert_mem
  description = "Name of the memory alert."
}
