class Prusactl < Formula
  desc "Hand your Prusa 3D printer to an AI agent (MCP server, with a CLI to set it up)"
  homepage "https://github.com/trevin-lee/prusactl"
  url "https://github.com/trevin-lee/prusactl/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "9f2c31557bc22b1a8550c8b654cb2b7696593cecc5879088ae2c81f9aff0fb01"
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
    # With nothing set up, status should say so rather than crash.
    output = shell_output("#{bin}/prusactl status 2>&1")
    assert_match "prusactl setup", output
  end
end
