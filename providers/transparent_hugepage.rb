require "shellwords"

def whyrun_supported?
  true
end

def get_file(key)
  file = begin
    case node["platform_family"]
    when "debian"
      "/sys/kernel/mm/transparent_hugepage/#{key}"
    when "redhat"
      "/sys/kernel/mm/redhat_transparent_hugepage/#{key}"
    else
      raise("Unknown platform family: #{node["platform_family"]}")
    end
  end
  if ::File.file?(file)
    file
  else
    raise("No transparent hugepage configuration: #{file}")
  end
end

def get_values(key)
  ::File.read(get_file(key)).scan(/\w+/)
end

def get_value(key)
  ::File.read(get_file(key)).scan(/(?<=\[)\w+(?=\])/).first
end

def update_value(key, value)
  values = get_values(key)
  unless values.include?(value)
    raise("Unknown parameter for transparent hugepage: #{key}=#{value} (available: #{values.join(", ")})")
  end

  execute "Set transparent hugepage #{key} to #{value}" do
    command "echo #{value.shellescape} > #{get_file(key).shellescape}"
    action :run
    only_if do
      get_value(key) != value
    end
  end
end

action :apply do
  if not new_resource.enabled.empty?
    update_value("enabled", new_resource.enabled)
  end
  if not new_resource.defrag.empty?
    update_value("defrag", new_resource.defrag)
  end
end

action :skip do
  # noop
end
