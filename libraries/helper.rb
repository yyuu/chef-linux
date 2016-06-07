require "shellwords"

module Linux
  module Helper
    def get_sysfs(path)
      ::File.read(path)
    end

    def set_sysfs(path, value, &block)
      execute "#{path} = #{value}" do
        command "echo #{::Shellwords.shellescape(value)} > #{::Shellwords.shellescape(path)}"
        if block
          only_if(&block)
        else
          only_if do
            get_sysfs(path) != value
          end
        end
      end
    end

    def get_sysfs_integer(path)
      get_sysfs(path).to_i
    end

    def set_sysfs_integer(path, value)
      set_sysfs(path, value) do
        get_sysfs_integer(path) != value
      end
    end

    def get_sysfs_choice(path)
      get_sysfs(path).scan(/(?<=\[)\w+(?=\])/).first
    end

    def set_sysfs_choice(path, value)
      set_sysfs(path, value) do
        get_sysfs_choice(path) != value
      end
    end

    def sys_kernel_mm_transparent_hugepage()
      if ::File.exist?("/sys/kernel/mm/transparent_hugepage")
        "/sys/kernel/mm/transparent_hugepage"
      else
        if ::File.exist?("/sys/kernel/mm/redhat_transparent_hugepage")
          "/sys/kernel/mm/redhat_transparent_hugepage"
        else
          fail("transparent_hugepage is not configurable")
        end
      end
    end
  end
end
