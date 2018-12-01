require "bundler/gem_tasks"
require "rake/testtask"

# task :spec do
#   Dir.glob('./spec/**/spec_*.rb').each { |file| require file}
# end
#
# task test: [:spec]
# task default: [:spec]

Rake::TestTask.new(:spec) do |t|
  t.libs << "spec"
  t.libs << "lib"
  t.test_files = FileList["spec/**/spec_*.rb"]
  t.options = '--color'
end

task :default => :spec
