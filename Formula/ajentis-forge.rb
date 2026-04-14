class AjentisForge < Formula
  desc "Forge your AI — from prototype to production. CLI for MCP servers & AI agents."
  homepage "https://ajentis.netlify.app/forge"
  license "MIT"

  # Version and SHA values are updated automatically by the ajentis-forge release workflow.
  # Do not edit manually.
  version "0.1.0"

  on_macos do
    on_arm do
      url "https://github.com/ajentis/homebrew-tap/releases/download/forge-v#{version}/ajentis-forge_v#{version}_darwin_arm64.tar.gz"
      sha256 "PLACEHOLDER"
    end

    on_intel do
      url "https://github.com/ajentis/homebrew-tap/releases/download/forge-v#{version}/ajentis-forge_v#{version}_darwin_amd64.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajentis/homebrew-tap/releases/download/forge-v#{version}/ajentis-forge_v#{version}_linux_arm64.tar.gz"
      sha256 "PLACEHOLDER"
    end

    on_intel do
      url "https://github.com/ajentis/homebrew-tap/releases/download/forge-v#{version}/ajentis-forge_v#{version}_linux_amd64.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  def install
    bin.install "ajnt"
  end

  test do
    assert_match "Ajentis Forge", shell_output("#{bin}/ajnt --version")
  end
end
