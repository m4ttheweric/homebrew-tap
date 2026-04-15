class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.0/rt-darwin-arm64-v1.0.0.tar.gz"
      sha256 "ce69050feccab660b6daf9f4e8c7efcf94a8cbc2a4c4ec2a4de4c1816a0cdf1c"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.0/rt-darwin-x64-v1.0.0.tar.gz"
      sha256 "87a7bd86a97a2c1a17fb7a9a5d2cac27c310077bbdfb622b0cf6d2566a7843db"
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
