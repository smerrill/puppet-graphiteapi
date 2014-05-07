require 'spec_helper'

describe 'graphiteapi' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "graphiteapi class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('graphiteapi::params') }
        it { should contain_class('graphiteapi::install').that_comes_before('graphiteapi::config') }
        it { should contain_class('graphiteapi::config') }
        it { should contain_class('graphiteapi::service').that_subscribes_to('graphiteapi::config') }

        it { should contain_service('graphiteapi') }
        it { should contain_package('graphiteapi').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'graphiteapi class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('graphiteapi') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
