include_recipe "linux"

%w(/dev/sd[a-z] /dev/xvd[a-z]).select { |block_device| ::File.blockdev?(block_device) }.each do |block_device|
  linux_io_scheduler ::File.basename(block_device) do
    block_device ::File.basename(block_device)
    scheduler "noop"
  end
end

linux_transparent_hugepage "Disable Transparent Hugepage Compaction" do
  defrag "never"
end
