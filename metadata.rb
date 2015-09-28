name 'watchman'
maintainer 'James Herdman'
maintainer_email 'james@precisionnutrition.com'
recipe 'watchman', 'Installs Watchman'
license 'MIT'
version '0.0.4'
depends 'sysctl'

# Because storing meta data in an executable format is brilliant... Ugh.. Chef :(
if respond_to?(:source_url)
  source_url 'https://github.com/PrecisionNutrition/chef-watchman'
end
