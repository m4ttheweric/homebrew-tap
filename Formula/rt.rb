class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.0/rt-darwin-arm64-v1.0.0.tar.gz"
      sha256 "80c4fe4de0b571b6dd571581fbc70cd854830ee9f3202ce7f947a42b82781cf2"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.0/rt-darwin-x64-v1.0.0.tar.gz"
      sha256 "60f260985d27efcead6994bd490ad886b44696db7bfecf19ef48127dad11a016"
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
      Configure your API tokens:
        rt settings linear token
        rt settings gitlab token

      Verify the installation:
        rt verify

      Restart your terminal, then run for detailed diagnostics:
        rt doctor
    EOS
  end
end
