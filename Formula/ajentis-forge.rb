class AjentisForge < Formula
  desc "Forge your AI — from prototype to production. CLI for MCP servers & AI agents."
  homepage "https://ajentis.netlify.app/forge"
  license "MIT"
  version "0.1.0"

  on_macos do
    on_arm do
      url "https://github.com/ajentis/homebrew-tap/releases/download/forge-v0.1.0/ajentis-forge_v0.1.0_darwin_arm64.tar.gz"
      sha256 "ab0309a3d7f8f164c0809bebc3b9569a1184048365db6b7485f12bedba13087a"
    end

    on_intel do
      url "https://github.com/ajentis/homebrew-tap/releases/download/forge-v0.1.0/ajentis-forge_v0.1.0_darwin_amd64.tar.gz"
      sha256 "5eef3a1aa26c7e0d9094ee750f04f687f3eef560a42590166085c66fa50b0ab1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajentis/homebrew-tap/releases/download/forge-v0.1.0/ajentis-forge_v0.1.0_linux_arm64.tar.gz"
      sha256 "4e74eaf67387bec7b2573c0a1c25ad5a0c6afdee172306053df3490dc77a4dd1"
    end

    on_intel do
      url "https://github.com/ajentis/homebrew-tap/releases/download/forge-v0.1.0/ajentis-forge_v0.1.0_linux_amd64.tar.gz"
      sha256 "0cac2767e69675e78dc2887d8fa2572a40308383edac74e178b2b90ae170af60"
    end
  end

  def install
    bin.install "ajnt"
  end

  test do
    assert_match "Ajentis Forge", shell_output("#{bin}/ajnt --version")
  end
end
