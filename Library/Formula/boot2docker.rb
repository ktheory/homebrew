require "formula"

class Boot2docker < Formula
  homepage "https://github.com/boot2docker/boot2docker"
  head "https://github.com/boot2docker/boot2docker.git"
  url 'https://github.com/boot2docker/boot2docker/archive/v0.9.0.tar.gz'
  sha1 '8be6007108eaca3c605e67997747063ba147a547'

  depends_on "docker" => :recommended

  def install
    bin.install "boot2docker"
  end

  def caveats; <<-EOS.undent
    Installing boot2docker virtual machine:
      boot2docker init
      boot2docker up

    Upgrading:
      boot2docker stop
      boot2docker download
      boot2docker up


    Forwarding ports from the vm to localhost:

      boot2docker stop
      for i in {49000..49900}; do
        VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$i,tcp,,$i,,$i";
        VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port$i,udp,,$i,,$i";
      done
      boot2docker up
    EOS
  end
end
