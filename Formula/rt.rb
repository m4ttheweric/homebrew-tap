class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.1.0/rt-darwin-arm64-v1.1.0.tar.gz"
      sha256 "4dd1bd17b45be579af1f1a9d53b15180c32a4b1c2fd4f129299052bdf7c9618d"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.1.0/rt-darwin-x64-v1.1.0.tar.gz"
      sha256 "640e191420555d4686108e04070b82ddcbe705313f96291427fe566deb1d1445"
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
