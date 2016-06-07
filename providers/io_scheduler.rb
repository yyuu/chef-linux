def whyrun_supported?
  true
end

include Linux::Helper

action :apply do
  if not new_resource.block_device.empty? and not new_resource.scheduler.empty?
    set_sysfs_choice("/sys/block/#{new_resource.block_device}/queue/scheduler", new_resource.scheduler)
  end
end

action :skip do
  # noop
end
