require "language/node"

class MarkdownlintCli < Formula
  desc "CLI for Node.js style checker and lint tool for Markdown files"
  homepage "https://github.com/igorshubovych/markdownlint-cli"
  url "https://registry.npmjs.org/markdownlint-cli/-/markdownlint-cli-0.28.1.tgz"
  sha256 "1a7a6170da3d2efabdfdf7bcc35873723733e40223aef6180bf2b8257308574c"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ed9779fa2a2cc0141debd2c61501681dcd2c78741ee47ea90726e65f52515d81"
    sha256 cellar: :any_skip_relocation, big_sur:       "d6454296ad369bb59d89724a04b36374946d5880eaaefc9690f617f5a74ff310"
    sha256 cellar: :any_skip_relocation, catalina:      "b005b2342165d9c7dbd528d57659fa4bbe6615c2fc6f7ea87fbec39cdb7857a5"
    sha256 cellar: :any_skip_relocation, mojave:        "802003979b630f36bfce119b8cd8a05ce34a006e19d94bbceb2040944167233b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "02efc301b7d7dfefbc9d6d42c3ee32417194ae4408165a505bd689e96b06e07c"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test-bad.md").write <<~EOS
      # Header 1
      body
    EOS
    (testpath/"test-good.md").write <<~EOS
      # Header 1

      body
    EOS
    assert_match "MD022/blanks-around-headings/blanks-around-headers",
                 shell_output("#{bin}/markdownlint #{testpath}/test-bad.md  2>&1", 1)
    assert_empty shell_output("#{bin}/markdownlint #{testpath}/test-good.md")
  end
end
