class GardenctlV2 < Formula
  desc "Gardenctl-v2"
  homepage "https://gardener.cloud"
  version "v2.1.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.1.0/gardenctl_v2_darwin_arm64"
      sha256 "7a7456ec0cb513e8ffe7405bbf57066c7249ae6301e1d687eeaa813a1a556b07"
    else
      url "https://github.com/gardener/gardenctl-v2/releases/download/v2.1.0/gardenctl_v2_darwin_amd64"
      sha256 "e03744ebd3f83c3e1e181c9ae6904457b588cf8a8bcb6ce21a402e97e7f7105d"
    end
  elsif OS.linux?
    url "https://github.com/gardener/gardenctl-v2/releases/download/v2.1.0/gardenctl_v2_linux_amd64"
    sha256 "ac3dd2a4db833d6bac363266857ce54f12619476ec8df1ac2743f8d2820d8b69"
    depends_on :arch => :x86_64
  end

  def install
    bin.install stable.url.split("/")[-1] => "gardenctl"
  end

  test do
    system "#{bin}/gardenctl", "version"
  end
end

