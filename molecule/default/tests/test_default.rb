# Test Integration For Users

# frozen_string_literal: true

describe user('tom') do
  it { should exist }
  its('group') { should eq 'tom' }
  its('groups') { should eq %w[tom sysadmin] }
  its('home') { should eq '/home/tom' }
  its('shell') { should eq '/bin/bash' }
end

describe user('mike') do
  it { should exist }
  its('group') { should eq 'mike' }
  its('groups') { should eq %w[mike webadmin] }
  its('home') { should eq '/home/mike' }
  its('shell') { should eq '/sbin/nologin' }
end

describe file('/home/tom/.ssh') do
  it { should be_a_directory }
  it { should exist }
  its('mode') { should cmp '0700' }
  its('owner') { should eq 'tom' }
  its('group') { should eq 'tom' }
end

describe file('/home/mike/.ssh') do
  it { should be_a_directory }
  it { should exist }
  its('mode') { should cmp '0700' }
  its('owner') { should eq 'mike' }
  its('group') { should eq 'mike' }
end

describe file('/home/tom/.ssh/authorized_keys') do
  it { should be_a_file }
  it { should exist }
  its('mode') { should cmp '0600' }
  its('owner') { should eq 'tom' }
  its('group') { should eq 'tom' }
end

describe file('/home/mike/.ssh/authorized_keys') do
  it { should be_a_file }
  it { should exist }
  its('mode') { should cmp '0600' }
  its('owner') { should eq 'mike' }
  its('group') { should eq 'mike' }
end

describe file('/home/tom/.bashrc') do
  it { should be_a_file }
  it { should exist }
  its('mode') { should cmp '0644' }
  its('owner') { should eq 'tom' }
  its('group') { should eq 'tom' }
end

describe file('/home/mike/.bash_profile') do
  it { should be_a_file }
  it { should exist }
  its('mode') { should cmp '0644' }
  its('owner') { should eq 'mike' }
  its('group') { should eq 'mike' }
end
