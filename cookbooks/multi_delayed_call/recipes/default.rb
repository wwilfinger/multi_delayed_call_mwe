delayed_ruby_block_times_called = 0

ruby_block "notifies_delayed_ruby_block" do
    block do
        Chef::Log.info "This is run before the custom resource call and notifies another ruby_block"
    end
    action :run
    notifies :run, 'ruby_block[delayed_ruby_block]', :delayed
end

multi_delayed_call "custom_resource" do
end

ruby_block "delayed_ruby_block" do
    block do
        Chef::Log.info "I am a delayed ruby_block resource that should be run only once"
        delayed_ruby_block_times_called += 1
        if delayed_ruby_block_times_called > 1
          Chef::Application.fatal! "ruby_block[delayed_ruby_block] called more than once!"
        end
    end
    action :nothing
end
