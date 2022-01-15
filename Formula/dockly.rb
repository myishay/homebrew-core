require "language/node"

class Dockly < Formula
  desc "Immersive terminal interface for managing docker containers, services and images"
  homepage "https://github.com/lirantal/dockly#readme"
  url "https://registry.npmjs.org/dockly/-/dockly-3.21.4.tgz"
  sha256 "87b2d87ea01eb43fdfd030c775df69249dd2ecae14d4452360d343095cbae943"
  license "MIT"

  depends_on "node"

  on_linux do
    depends_on "libx11"
  end

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    require "pty"
    r, _, pid = PTY.spawn "#{bin}/dockly"
    sleep 1
    Process.kill("TERM", pid)
    assert_match(/Dockly/, r.read)
  end
end
