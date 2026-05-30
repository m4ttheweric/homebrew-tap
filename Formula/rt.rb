class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.2.0/rt-darwin-arm64-v1.2.0.tar.gz"
      sha256 "8fac6cd5e7eacefafa60a5f9470a2fa2a1c7d5339bd0228e9bc22488a1208a00"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.2.0/rt-darwin-x64-v1.2.0.tar.gz"
      sha256 "937fe13b9f3f803b6174e3456f4409397c53034ea1930fc6adcca220a867983e"
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
