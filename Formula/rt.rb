class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "0.0.0"
  license "MIT"

  # This formula is auto-updated by GitHub Actions on each release.
  # Install: brew install m4ttheweric/tap/rt
  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v0.0.0/rt-darwin-arm64-v0.0.0.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v0.0.0/rt-darwin-x64-v0.0.0.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  depends_on :macos
  depends_on "fzf"
  depends_on "terminal-notifier" => :recommended
  depends_on "zellij" => :recommended

  def install
    bin.install "rt"
    prefix.install "rt-tray.app"
    prefix.install "rt-context.vsix"
  end

  def post_install
    # Tray app → ~/Applications
    apps_dir = Pathname.new(Dir.home) / "Applications"
    apps_dir.mkpath
    FileUtils.rm_rf(apps_dir / "rt-tray.app")
    FileUtils.cp_r(prefix / "rt-tray.app", apps_dir / "rt-tray.app")
    system "xattr", "-cr", (apps_dir / "rt-tray.app").to_s

    # Extension → local editors
    vsix = (prefix / "rt-context.vsix").to_s
    system "cursor", "--install-extension", vsix, "--force" if which("cursor")
    system "code", "--install-extension", vsix, "--force" if which("code")

    # Daemon (non-interactive)
    system bin / "rt", "daemon", "install", "--manual"

    # Shell integration
    zshrc = Pathname.new(Dir.home) / ".zshrc"
    marker = "# rt — repo tools"
    unless zshrc.exist? && zshrc.read.include?(marker)
      zshrc.open("a") do |f|
        f.puts "", marker
        f.puts 'rt-cd() { local dir=$(rt cd 2>/dev/null); [ -n "$dir" ] && cd "$dir"; }'
        f.puts "alias rtcd='rt-cd'"
      end
    end
  end

  def caveats
    <<~EOS
      Configure your API tokens:
        rt settings linear token
        rt settings gitlab token

      Restart your terminal, then verify:
        rt doctor
    EOS
  end
end
