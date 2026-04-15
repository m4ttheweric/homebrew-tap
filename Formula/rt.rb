class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.0.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.2/rt-darwin-arm64-v1.0.2.tar.gz"
      sha256 "fd94a60d95b5f4693a81d43a0609820d42550d826435c404002608dfed9a2421"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.2/rt-darwin-x64-v1.0.2.tar.gz"
      sha256 "0554ddf7062c8171e47b68ef90e9666b9191c70d6375f54661de210d9f148795"
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
