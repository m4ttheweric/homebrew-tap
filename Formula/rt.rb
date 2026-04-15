class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.0.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.3/rt-darwin-arm64-v1.0.3.tar.gz"
      sha256 "7ebb4f6eb72e354533bd2fcfe86603d3fce2224f01546785a0397b0d3b7d3655"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.3/rt-darwin-x64-v1.0.3.tar.gz"
      sha256 "041689962f5a898c02209ea10f94b1092bc4be1578bf9c6d6950d13536fd4397"
    end
  end

  depends_on :macos
  depends_on "fzf"
  depends_on "tmux"

  def install
    bin.install "rt"
    prefix.install "rt-tray.app"
    prefix.install "rt-context.vsix"
  end

  def post_install
    # All setup logic lives in the binary — versioned alongside the code.
    system bin / "rt", "--post-install"
  end


  def caveats
    <<~EOS
      Complete setup (tray app, daemon, shell integration):
        rt --post-install

      Then configure your API tokens:
        rt settings linear token
        rt settings gitlab token

      Verify the installation:
        rt verify
    EOS
  end
end
