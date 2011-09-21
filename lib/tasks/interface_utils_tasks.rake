namespace :interface_utils do
  desc "Syncronize extra files for Interface Utilities."
  task :sync do
    system "rsync -ruv --exclude '.*' vendor/plugins/interface_utils/public ."
  end
end