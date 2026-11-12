# Rendered by checks/homebrew-formula from assets/homebrew/macserve.rb.tmpl
# for v0.1.47. Do not edit by hand: copy the release asset into the tap.
class Macserve < Formula
  desc "Hardened GitHub Actions runner service for a Mac"
  homepage "https://github.com/jerryfane/macserve"
  url "https://github.com/jerryfane/macserve/releases/download/v0.1.47/macserve-darwin-arm64"
  version "0.1.47"
  sha256 "0d33fcb53da94d27ecf5a221a0520e99e80175cd1120de2a3183ccec060a853d"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on :macos

  resource "macserve-controller" do
    url "https://github.com/jerryfane/macserve/releases/download/v0.1.47/macserve-controller-darwin-arm64"
    sha256 "e07093547a0ad0158393e1d4c364c89f00e87871512b7bac14a0636cdc1faa6f"
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
