# Rendered by checks/homebrew-formula from assets/homebrew/macserve.rb.tmpl
# for v0.1.35. Do not edit by hand: copy the release asset into the tap.
class Macserve < Formula
  desc "Hardened GitHub Actions runner service for a Mac"
  homepage "https://github.com/jerryfane/macserve"
  url "https://github.com/jerryfane/macserve/releases/download/v0.1.35/macserve-darwin-arm64"
  version "0.1.35"
  sha256 "f18761f622c2b249ee9344e2a77a83cee0f20cc4a7fdd90e97df8b76fc1b296a"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on :macos

  def install
    # The Homebrew copy is owner-writable and is never the service binary:
    # macserve setup verifies the release digest and copies those bytes into
    # root-owned /Library/macserve/bin itself.
    bin.install "macserve-darwin-arm64" => "macserve"
  end

  def caveats
    <<~EOS
      This installs the macserve command only; nothing is configured or started.
      Begin with the read-only preflight, run as yourself (not with sudo):
        macserve setup --plan
      Setup verifies the release SHA256SUMS before copying the binary into
      root-owned /Library/macserve/bin; this Homebrew copy is never the service.
    EOS
  end

  test do
    system bin/"macserve", "--help"
  end
end
