# Rendered by checks/homebrew-formula from assets/homebrew/macserve.rb.tmpl
# for v0.1.36. Do not edit by hand: copy the release asset into the tap.
class Macserve < Formula
  desc "Hardened GitHub Actions runner service for a Mac"
  homepage "https://github.com/jerryfane/macserve"
  url "https://github.com/jerryfane/macserve/releases/download/v0.1.36/macserve-darwin-arm64"
  version "0.1.36"
  sha256 "8a78f783335083fbdb12a8bd39b88b0e6f5160f5e0d9b24a9ea0a6ecba06647e"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on :macos

  resource "macserve-controller" do
    url "https://github.com/jerryfane/macserve/releases/download/v0.1.36/macserve-controller-darwin-arm64"
    sha256 "43f0a4c20c4ef5ba99dc9c675a98bc56b721076ccb716cd0b346d617c499a902"
  end

  def install
    # The Homebrew copy is owner-writable and is never the service binary:
    # macserve setup verifies the release digest and copies those bytes into
    # root-owned /Library/macserve/bin itself.
    bin.install "macserve-darwin-arm64" => "macserve"
    resource("macserve-controller").stage do
      bin.install "macserve-controller-darwin-arm64" => "macserve-controller"
    end
  end

  def caveats
    <<~EOS
      This installs the macserve and macserve-controller commands only; nothing is configured or started.
      Begin with the read-only preflight, run as yourself (not with sudo):
        macserve setup --plan
      Setup verifies the release SHA256SUMS before copying the binary into
      root-owned /Library/macserve/bin; these Homebrew copies are never the service.
    EOS
  end

  test do
    system bin/"macserve", "--help"
    system bin/"macserve-controller", "--help"
  end
end
