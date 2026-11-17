# Rendered by checks/homebrew-formula from assets/homebrew/macserve.rb.tmpl
# for v0.1.61. Do not edit by hand: copy the release asset into the tap.
class Macserve < Formula
  desc "Hardened GitHub Actions runner service for a Mac"
  homepage "https://github.com/jerryfane/macserve"
  url "https://github.com/jerryfane/macserve/releases/download/v0.1.61/macserve-darwin-arm64"
  version "0.1.61"
  sha256 "08e3f7cb77fb58a77e5db8e96af868153de8346d6ca5d1f155ea6d4fb9ae9150"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on :macos

  resource "macserve-controller" do
    url "https://github.com/jerryfane/macserve/releases/download/v0.1.61/macserve-controller-darwin-arm64"
    sha256 "06f6fe1ba513220919320870cff3e59afb36d6e3e6662b9cbb8a417ffcbbbc8b"
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
