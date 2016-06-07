use_inline_resources

def whyrun_supported?
  true
end

include Linux::Helper

action :apply do
  if not new_resource.block_device.empty? and not new_resource.scheduler.empty?
    set_sysfs_choice("/sys/block/#{::File.basename(new_resource.block_device)}/queue/scheduler", new_resource.scheduler)
    new_resource.updated_by_last_action(true)
  end
end

action :skip do
  # noop
end
