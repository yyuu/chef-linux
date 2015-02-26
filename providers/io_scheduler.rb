require "shellwords"

def whyrun_supported?
  true
end

def get_file(block_device)
  file = "/sys/block/#{block_device}/queue/scheduler"
  if ::File.file?(file)
    file
  else
    raise("Unknown block device: #{block_device}")
  end
end

def get_values(block_device)
  ::File.read(get_file(block_device)).scan(/\w+/)
end

def get_value(block_device)
  ::File.read(get_file(block_device)).scan(/(?<=\[)\w+(?=\])/).first
end

def update_value(block_device, value)
  values = get_values(block_device)
  unless values.include?(value)
    raise("Unknown I/O scheduler: #{value} (available: #{values.join(", ")})")
  end

  execute "Set I/O scheduler on #{block_device} to #{value}" do
    command "echo #{value.shellescape} > #{get_file(block_device).shellescape}"
    action :run
    only_if do
      get_value(block_device) != value
    end
  end
end

action :apply do
  if not new_resource.block_device.empty? and not new_resource.scheduler.empty?
    update_value(::File.basename(new_resource.block_device), new_resource.scheduler)
  end
end

action :skip do
  # noop
end
