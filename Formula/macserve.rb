# Rendered by checks/homebrew-formula from assets/homebrew/macserve.rb.tmpl
# for v0.1.40. Do not edit by hand: copy the release asset into the tap.
class Macserve < Formula
  desc "Hardened GitHub Actions runner service for a Mac"
  homepage "https://github.com/jerryfane/macserve"
  url "https://github.com/jerryfane/macserve/releases/download/v0.1.40/macserve-darwin-arm64"
  version "0.1.40"
  sha256 "11831013d1ed8f90f9642b9382144dae7fba50b6201e1aa3ca161c9c0cbe1e8d"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on :macos

  resource "macserve-controller" do
    url "https://github.com/jerryfane/macserve/releases/download/v0.1.40/macserve-controller-darwin-arm64"
    sha256 "a1777c20773b705f4341d5d3e87105cf132ad39ed197a8a90a386cbe81688cdd"
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
