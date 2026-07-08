class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "2.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.3.0/rt-darwin-arm64-v2.3.0.tar.gz"
      sha256 "6c4147bc1f5373a3b7972d0c115da1d1fe3aeca2d78cf2b3f01e0458d37ab846"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.3.0/rt-darwin-x64-v2.3.0.tar.gz"
      sha256 "379ddf115807d23dc567d304c185f3e74edde4d79eba46bdd18d3e677a3e25a1"
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
