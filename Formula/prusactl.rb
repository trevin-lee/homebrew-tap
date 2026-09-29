class Prusactl < Formula
  desc "Hand your Prusa 3D printer to an AI agent (MCP server, with a CLI to set it up)"
  homepage "https://github.com/trevin-lee/prusactl"
  url "https://github.com/trevin-lee/prusactl/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "39e1c0975c42c8479cd81a40f2b26ecebebd6a26fa2097de2ec6febef343fc8f"
  license "MIT"
  head "https://github.com/trevin-lee/prusactl.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/prusactl"
    generate_completions_from_executable(bin/"prusactl", "completion", base_name: "prusactl")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prusactl --version")
    # No printer set up: it should say so and exit non-zero, not crash.
    output = shell_output("#{bin}/prusactl status 2>&1")
    assert_match "prusactl setup", output
  end
end
