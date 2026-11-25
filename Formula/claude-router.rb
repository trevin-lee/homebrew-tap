class ClaudeRouter < Formula
  desc "Keep several Claude accounts signed in at once, switch between them, see usage"
  homepage "https://github.com/trevin-lee/claude-router"
  url "https://github.com/trevin-lee/claude-router/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "3f4c6f50e74e65a92a6c022c6e5bd1877d4499a774ecfa84642f24496dcba587"
  license "MIT"
  head "https://github.com/trevin-lee/claude-router.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/claude-router"
    generate_completions_from_executable(bin/"claude-router", "completion")
  end

  def caveats
    <<~EOS
      Sign each account in once:
        claude-router login 0
      Then start Claude Code as an account with:
        claude-router use 0
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/claude-router --version")
    # With no account folders, status says how to create them rather than crash.
    ENV["CLAUDE_ROUTER_DIR_PREFIX"] = testpath/".claude-"
    ENV["CLAUDE_ROUTER_CACHE"] = testpath/"cache"
    assert_match "claude-router login 0", shell_output("#{bin}/claude-router status")
  end
end
