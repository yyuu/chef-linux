def whyrun_supported?
  true
end

action :apply do
  if not new_resource.enabled.empty?
    set_sysfs_choice("#{sys_kernel_mm_transparent_hugepage}/enabled", new_resource.enabled)
  end
  if not new_resource.defrag.empty?
    set_sysfs_choice("#{sys_kernel_mm_transparent_hugepage}/defrag", new_resource.defrag)
  end
end

action :skip do
  # noop
end
