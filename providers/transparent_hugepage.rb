use_inline_resources

def whyrun_supported?
  true
end

include Linux::Helper

action :apply do
  if not new_resource.enabled.empty?
    set_sysfs_choice("#{sys_kernel_mm_transparent_hugepage}/enabled", new_resource.enabled)
    new_resource.updated_by_last_action(true)
  end
  if not new_resource.defrag.empty?
    set_sysfs_choice("#{sys_kernel_mm_transparent_hugepage}/defrag", new_resource.defrag)
    new_resource.updated_by_last_action(true)
  end
end

action :skip do
  # noop
end
