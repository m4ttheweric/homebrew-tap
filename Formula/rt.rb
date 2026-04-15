class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.0.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.6/rt-darwin-arm64-v1.0.6.tar.gz"
      sha256 "b4b50e685880c44097f8bab48628da4cc0b69b57c0536ae58c7f7672d3e1a6ea"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.6/rt-darwin-x64-v1.0.6.tar.gz"
      sha256 "333aeb76a114f19582207db0d3853f1f02375319fc914fa62ae9b44f9f8dac54"
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
