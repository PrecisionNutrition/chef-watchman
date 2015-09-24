package "libpcre3-dev"
package "python-dev"

# e.g. https://github.com/facebook/watchman/archive/v3.0.0.tar.gz
target_url = "https://github.com/facebook/watchman/archive/#{node['watchman']['version']}.tar.gz"

src_path = "/tmp"
src_file = "watchman-#{node['watchman']['version']}"
src_compressed_file = "#{src_file}.tar.gz"
src_filepath = "#{src_path}/#{src_compressed_file}"
extract_path = "#{src_path}/#{src_file.sub(/v/, '')}" # watchman-v3.0.0.tar.gz => watchman-3.0.0

remote_file(src_filepath) do
  action :create_if_missing

  source target_url

  # Prevents re-downloading the file
  use_conditional_get true if respond_to?(:use_conditional_get)
  use_etag true if respond_to?(:use_etag)

  owner 'vagrant'
  group 'vagrant'
end

bash 'extract watchman' do
  cwd src_path
  code "tar xvzf #{src_compressed_file} && cd #{extract_path} && ./autogen.sh && ./configure && make && sudo make install"

  not_if { ::File.exists?(extract_path) }
end

include_recipe 'sysctl::default'
sysctl_param 'fs.inotify.max_user_watches' do
  value node['watchman']['max_user_watches']
  only_if { node['watchman']['max_user_watches'] }
end
