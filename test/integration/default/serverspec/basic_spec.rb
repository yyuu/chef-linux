$LOAD_PATH << File.expand_path("..", __FILE__)
require "serverspec"

set :backend, :exec

%w(/dev/sd[a-z] /dev/xvd[a-z]).select { |block_device| ::File.blockdev?(block_device) }.each do |block_device|
  describe file("/sys/block/#{block_device}/queue/scheduler") do
    it { should exist }
    its(:content) { should match /\[noop\]/ }
  end
end

if ::File.exist?("/sys/kernel/mm/transparent_hugepage")
  describe file("/sys/kernel/mm/transparent_hugepage/defrag") do
    it { should exist }
    its(:content) { should contain "never" }
  end
end

if ::File.exist?("/sys/kernel/mm/redhat_transparent_hugepage")
  describe file("/sys/kernel/mm/redhat_transparent_hugepage/defrag") do
    it { should exist }
    its(:content) { should contain "never" }
  end
end
