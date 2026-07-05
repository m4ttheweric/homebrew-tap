class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "2.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.0.0/rt-darwin-arm64-v2.0.0.tar.gz"
      sha256 "12eda36993ce542bb2594720d0f85fd30986839438cf3d32917b4e542832baad"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.0.0/rt-darwin-x64-v2.0.0.tar.gz"
      sha256 "ca2dcefbdc3de8e7c86ccc67617d92ef847175cd63241e440f7875784cab1b1a"
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
