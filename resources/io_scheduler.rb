actions :apply, :skip
default_action :apply

attribute :block_device, :kind_of => String, :default => ""
attribute :scheduler, :kind_of => String, :default => ""
