class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.0.16"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.16/rt-darwin-arm64-v1.0.16.tar.gz"
      sha256 "cb2094bfa3ca03f44c58f01c6884d13e66ef9415d5d40faaa3f1b8497546f0ad"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.16/rt-darwin-x64-v1.0.16.tar.gz"
      sha256 "dbd7e89cea1233d16327b6f3713ba3bf7c4f6d303a4088f041ac21f325e492f2"
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

  # No post_install hook: Homebrew runs hooks in a sandbox that can't
  # write to ~/Applications, ~/.rt, or shell rc files. Setup is handled
  # by the binary on first invocation (or via `rt verify`).

  def caveats
    <<~EOS
      Complete setup + verify the install:
        rt verify

      Then configure your API tokens:
        rt settings linear token
        rt settings gitlab token
    EOS
  end
end
