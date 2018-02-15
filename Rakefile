require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = './test/**/*_test.rb'
end

Rake::TestTask.new(:test_paths) do |t|
  t.pattern = './test/paths/*_test.rb'
end

task default: [:test]
