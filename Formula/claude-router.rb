class ClaudeRouter < Formula
  desc "Use several Claude accounts as one, with a shared setup and automatic switching"
  homepage "https://github.com/trevin-lee/claude-router"
  url "https://github.com/trevin-lee/claude-router/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "24768f121280539e138794ef6150c59fc40832497e12cdacd13d5bceea473091"
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
      Then let claude pick the account with the most room, in ~/.zshrc:
        claude() { claude-router launch "$(whence -p claude)" "$@"; }
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
