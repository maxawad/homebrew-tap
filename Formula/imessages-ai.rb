# Homebrew formula for iMessages AI
# Install: brew install maxawad/tap/imessages-ai

class ImessagesAi < Formula
  desc "ChatGPT-powered auto-responder for iMessage"
  homepage "https://github.com/maxawad/imessages-ai"
  url "https://github.com/maxawad/imessages-ai/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "b24b0c45111b8236b669387f06bc8614d0d10d8ae6d986acf4964104fb9e42a1"
  license "MIT"
  head "https://github.com/maxawad/imessages-ai.git", branch: "main"

  depends_on :macos

  def install
    libexec.install "lib/imessages_ai.py"

    # Rewrite the CLI to point at the installed lib path
    inreplace "bin/imessages-ai" do |s|
      s.gsub! 'LIB_DIR="$(cd "$SCRIPT_DIR/../lib" && pwd)"',
              "LIB_DIR=\"#{libexec}\""
    end
    bin.install "bin/imessages-ai"
  end

  def post_install
    # Install openai into a dedicated pip prefix
    system "python3", "-m", "pip", "install", "--target=#{libexec}/python", "openai"
  end

  def caveats
    <<~EOS
      Get started:

        imessages-ai setup

      Then start the listener:

        imessages-ai start        # background service (auto-starts on login)
        imessages-ai run          # foreground mode

      IMPORTANT: Your terminal needs Full Disk Access to read Messages.
        System Settings > Privacy & Security > Full Disk Access > enable Terminal/iTerm

      Config: ~/.config/imessages-ai/config
      Logs:   ~/Library/Logs/imessages-ai/
    EOS
  end

  test do
    assert_match "imessages-ai", shell_output("#{bin}/imessages-ai --version")
  end
end
