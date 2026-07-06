class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "2.0.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.0.1/rt-darwin-arm64-v2.0.1.tar.gz"
      sha256 "db911671b8b6b620a032e0fdb5a272ec4ba776eb1af9188b226b46a382d6ab89"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.0.1/rt-darwin-x64-v2.0.1.tar.gz"
      sha256 "e96b161822b0933656e8ecdec14bbfb174b4661f57b0c085d03ee7e1d00bee52"
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
